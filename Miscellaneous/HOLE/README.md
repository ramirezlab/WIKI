# Welcome to the Ramirez Lab Wiki - Miscellaneous section -> HOLE

Here we will use HOLE suite of programs to study pores in potassium channels. For more information go to [Yale](http://www.csb.yale.edu/userguides/graphics/hole/doc/hole_d00.html#contents) and [Here](http://www.holeprogram.org/doc/) 

Several HOLE programs have been used in the _hole_over_time.tcl_ script to produce surface representations of pore cavities. You can use this script to study pores along trajectories or in a static representation.  

>Tip: First align the cavity of your protein (ion channel, pore, etc) to the Z-axis (x,y,z = 0,0,1), and center it (x,y,z = 0,0,0)


Usage: Load your target protein into VMD and use the VMD´s Tk console: 
>play hole_over_time.tcl 


#### hole_over_time.tcl 
```markdown
# % $Id: residue_rmsd.tcl,v 1.3 2005/03/29 18:10:41 sotomayo Exp $
# Modified by David Ramírez (2014) - Ramirez Lab.

proc hole_over_time { A B C D} {
  # Customize the following lines to set the paths to the hole executable and
  # the radius file.
  set holebin hole/hole2/exe/hole
  set holerad hole/hole2/rad/simple.rad
  set sph_process hole/hole2/exe/sph_process
  set sos_triangle hole/hole2/exe/sos_triangle 
  set tmp /tmp
  # Customize the following to set default values.  See the runhole 
  # comments for what these parameters do.
  #cvect vector en poro, cpoint punto en poro
set cvect $B	
#set cvect [list 0 0 10]
#  set cpoint [list -6 5 10]
set cpoint $A
set tmp $C
cd $tmp
  set sample 0.5
  set endrad 30.
  set mol top
#variable sel 1
    # use frame 0 for the reference
      set num_steps [molinfo $mol get numframes]
 
    #loop over all frames in the trajectory
   set radio_trayect [open radio_trayect.log w]  

for {set frame 0} {$frame < $num_steps} {set frame [expr $frame+1]} {
	puts "Calculando hole $frame "
	set sphpdb outputhole_$frame.sph
  	set pltout outputhole_$frame.qpt

	
# write coordinates to files
puts $mol
set sel [atomselect $mol "protein" frame $frame]  
set pdb tmpholeinputfiles_$frame.pdb
$sel writepdb $pdb

  # construct HOLE input string
  set str "\ncoord $pdb\n"
  append str "radius $holerad\n"
  append str "cvect $cvect\n"
  append str "cpoint $cpoint\n"
if { $D == "Y" } {  
append str "capsule \n"
}

  append str "sample $sample\n"
  append str "endrad $endrad\n"
  append str "sphpdb $sphpdb\n"
  append str "pltout $pltout\n"
  
 # set str2 "-dotden 15 -colour -sos outputhole.sph hole.sos"
# Call HOLE and collect output
puts "Calling HOLE..."
set holeinp [open hole_$frame.inp w]
puts $holeinp $str
close $holeinp
puts "$holebin $str "
flush stdout
  set result [exec  "$holebin" "<< $str >> hole.log"]

#capturando archivos de salida 
set rawdata [list]
  set lines [split $result \n]
  set n [llength $lines]
  set archiv [open hole_$frame.log w] 
  set archiv2 [open hole_residuos_$frame.log w]
for { set i 0 } { $i < $n } {set i [expr $i+1] } {
    set line [lindex $lines $i]
    # buscando resumen final
if { [string first "(TAG" $line] != -1 } {
set lined [lindex $lines $i]
set radio [string trim [string range $lined 22 37]]
set conduct [string trim [string range $lined 44 57]]
puts $radio_trayect "$frame \t $radio \t $conduct"
}
##
	if { [string first highest $line] != -1 } {
      incr i
      foreach { at point x y z } [lindex $lines $i] { break }
      incr i
      set line [lindex $lines $i]
      set r [string trim [string range $line 22 30]]
      set aname [string trim [string range $line 31 37]]
      set resname [string trim [string range $line 38 40]]
      set resid [string trim [string range $line 44 end]]
      lappend rawdata [list $z $r $resname $resid]
    }
  }
  set sortdata [lsort -real -index 0 $rawdata]
  #return $sortdata
  puts $archiv "$result"
  puts $archiv2 "$sortdata"
close $archiv
close $archiv2



	    
# fin loop por frame	
    }
    close $radio_trayect
}

proc superficies { } {
set mol top 
set num_steps [molinfo $mol get numframes]
  set arc2 [open hole_surf_bash.bash w]
set dir [eval pwd] 
cd $dir 	
#set tmp /tmp
      #  set arg1 
#puts $arg1
puts $arc2 "#!/bin/bash \n"
puts $arc2 "cd $dir \n"
for {set frame 0} {$frame < $num_steps} {set frame [expr $frame+1]} {
	puts "Calculando superficie $frame "
	set sphpdb outputhole_$frame.sph
	set sphsos outputhole_$frame.sos
  	set pltout outputhole_$frame.qpt
	set sph_process hole/hole2/exe/sph_process
  	set sos_triangle hole/hole2/exe/sos_triangle 
	
puts $arc2 "$sph_process -dotden 15 -color -sos $sphpdb $sphsos "
puts $arc2 "$sos_triangle -s -v <$sphsos >surf_$frame.vmd"
}
close $arc2
puts stdout [exec chmod 777 hole_surf_bash.bash]
flush stdout
puts "El proceso de creacion de superficies parecera que se cuelga el pc, esperar"
puts stdout [exec "$dir/hole_surf_bash.bash"]
flush stdout

}

proc Hole_DAV { } {
set dir1 [eval pwd]
puts "ingresar punto en el poro"
set A [gets stdin]
puts "ingresar vector paralelo"
set B [gets stdin]
set dir /tmp
set D "N"
puts " ocupar CAPSULE Y/N (default N)"
set D [gets stdin]
puts " en que directorio guardamos los datos"
set dir [gets stdin]
#flush stdin
cd $dir
hole_over_time $A $B $dir $D
superficies 
cd $dir1
puts "\a He finalizado los resultados estan en $dir"
}


```

To see some examples please vivist the [Ramirez Lab - publication sections](https://ramirezlab.github.io/3_publications) 

Thanks!!!
