############################################################################
#cr
#cr            (C) Copyright 1995 The Board of Trustees of the
#cr                        University of Illinois
#cr                         All Rights Reserved
#cr
############################################################################

############################################################################
# RCS INFORMATION:
#
#       $RCSfile: .vmdrc,v $
#       $Author: johns $        $Locker:  $                $State: Exp $
#       $Revision: 1.5 $      $Date: 2000/05/23 16:00:17 $
#
############################################################################
# DESCRIPTION:
#
# VMD startup script.  The commands here are executed as soon as VMD starts up
############################################################################
# Modified by Andriy Anishkin (anishkin@icqmail.com) UMCP

# turn on lights 0 and 1
light 0 on
light 1 on
light 2 off
light 3 off
display nearclip set 0

# position the stage and axes
#axes location lowerleft
axes location off
stage location off

# change background color
color Display Background white
color Labels Atoms black
color Labels Bonds black
color Display FPS black
color Axes Labels black

# position and turn on menus
menu main     move 5   540
menu animate  move 125 30
menu edit     move 125 225
menu tracker  move 125 520
menu display  move 395 30
menu graphics move 704 139
menu color    move 125 225
menu files    move 570 483
menu molecule move 125 525
menu labels   move 661 29
menu render   move 125 525
menu sequence move 629 0

# # position and turn on menus
# menu main     move 7   785
# menu animate  move 125 30
# menu edit     move 125 225
# menu tracker  move 125 520
# menu display  move 395 30
# menu graphics move 912 332
# menu color    move 125 225
# menu files    move 825 502
# menu molecule move 125 525
# menu labels   move 912 29
# menu render   move 125 525
# menu sequence move 881 0

menu main     on
#menu animate  on
#menu edit     on
#menu tracker  on
#menu display  on
#menu graphics on
#menu color    on
#menu labels   on
#menu renderer on
#menu moledule on
#menu files    on




# start the scene a-rockin'
#rock y by 1

display projection orthographic
cd c:/temp
catch {lappend auto_path {c:/Program Files/University of Illinois/VMD/scripts/vmd/la1.0}};
catch {lappend auto_path {c:/Program Files/University of Illinois/VMD/scripts/vmd/orient}};
catch {package require Orient};
catch {namespace import Orient::orient};

proc h { } {
	# Prints help for keyboard shortcuts to the screen
	puts "
______________________ Hot Keys (for OpenGL Window): ______________________
	
___ Mouse mode ___
R	enter rotate mode; stop rotation
T	enter translate mode
S	enter scaling mode
C	assign rotation center
0	query item; show labels menu
1	pick atom
2	pick bond (2 atoms)
3	pick angle (3 atoms)
4	pick dihedral (4 atoms)
5	move atom
6	move residue
7	move fragment 
8	move molecule
9	move highlighted rep


___ View ___
Q	view from positive direction of x axis
W	view from positive direction of y axis
E	view from positive direction of z axis
F	flip view 180º (view from the back of the current view)
X	spin about x axis
Y	spin about y axis
Z	spin about z axis
J	rotate 2º about x
K	rotate -2º about x
L	rotate 2º about y
H	rotate -2º about y


___ Representations ___
N	apply preselected graphical representation (new ribbons colored by index)
I	apply preselected graphical representation (trace colored by index)
V	set white background and 'exp2' depth cue
B	set black background without depthcue
P	switch depthcue on and off
U	make the selections of the top molecule to auto update each frame
A	apply representations from the top molecule to all other molecules

___ Additional graphics ___
O (o)	draw coordinate cylinders in origin (red x, green y, blue z)
G	draw coordinate greed (red x, green y, blue z). One tick 1Å, small
	 square 5Å, big square 10Å.
D	remove all the graphics added


___ Menus ___
\[	show main menu
\]	show files menu, and set the current folder as of the top molecule file
'	show graphics (Graphical Representations) menu
\\	show sequence menu
\;	show tkcon Tcl console (Works after the first use of Extensions -> tkcon)


___ Animation ___
+	move to next frame
-	move to previous frame
. >	play animation forward
, <	play animation reverse
/ ?	stop animation


___ Modifications ___
M	move geometry center of the molecule to the origin
` ~	orient top molecule (not more than 50,000 atoms) by principal axes
	 (requires Orient script written by Paul Grayson and  linear algebra
	 package by Hume Integration Software)

______________________ Text Commands (for the console): ______________________
h	Show this list of Hot keys and Text commands
a	Loads coordinates from the filelist and adds them as new frames to the top molecule
	Syntax: a {file1.coor file2.pdb file3.dcd}; a {c:/temp} {file1.dcd} 10
	Filenames can be separated by new lines. First argument can be path to files, it can be
	omitted or empty. The third argument can be step for trajectory reading or can be omitted.
	Filename can include full path.
n	Loads coordinates from the filelist and adds them as new files.
	Syntax: n {file1.coor file2.pdb file3.dcd}; n {c:/temp} {file1.dcd} 10
	Filenames can be separated by new lines. First argument can be path to files, it can be
	omitted or empty. The third argument can be step for trajectory reading or can be omitted.
t	sets current working folder to 'C:/Temp'
c	sets current working folder to the path to the first loaded file of the top molecule
pdb	Write current frame of the top file to a pdb file <old_name>_.pdb
fx	Rotate (flip) protein 180 degrees around x axis (changes coordinates)
fy	Rotate (flip) protein 180 degrees around y axis (changes coordinates)
fz	Rotate (flip) protein 180 degrees around z axis (changes coordinates)
colstart	Starts collaboration session between two VMD machines
colstop 	Stops collaboration session between two VMD machines
betascale	Sets beta value of protein residues to the value found in the
	 selected hydrophobicity scale. 
	 Usage: 'betascale' - prints the list of
	 scales; 'betascale <scale_name>' - assigns values from the scale ; 
	 'betascale <scale_name> scale' -  assigns values from the scale and 
	 prints scale values on the console screen
bs	Same as 'betascale'
mutant	Creates mutant of the protein from the current structure. 
	Usage: 'mutant <resnum> <mutant_restype>' E.g.: 'mutant 109 THR 115 VAL'
morph	Adds frames with linear interpolation between the existing frames of the top 
	molecule. Usage: 'morph <frames_increase_factor> <frames_insertion_frequency_type>'
	or 'morph <start:frames_increase_factor:end> <frames_insertion_frequency_type>'
	E.g. 'morph 10' 'morph 2 linear' 'morph 3 cycle' 'morph 100 sin2' 'morph 3:10:4 linear'
cell	Sets the cell size for periodic images. 
	Usage: cell <{Specified a, b, c, alpha, beta, gamma}|{line from xsc file}|{cell
	parameters from NAMD configuration}|{xsc filename}>
	E.g. 'cell {100 110 120 90 90 60}' 'cell {sim-mscs-007.xsc}'
symm	calculate symmetric structure closest to the starting structure of homooligomer,
 	or spread conformation of one monomer onto the whole oligomer.
 	Usage: symm <|\"selection_string\"> <|monomer_index|symmetrization_mode>.
 	monomer_index: integer 0 to (number_of_monomers - 1)
 	symmetrization_mode: 'avg' - average, 'max' - the most different monomer, 
 	'min' - monomer closest to the average. E.g. 'symm' 'symm \"resid 23\"'
 	'symm min' 'symm max' 'symm avg' 'symm \"resid 23\" 0'
 	'symm' is equivalent to 'symm \"protein\" max'
radii	sets atomic VDW radii according to the values read from the predefined values,
	 or from file with atom types and radii, or from CHARMM parameters file.
	Syntax: radii {}  ==> Displays brief help and sets predefined CHARMM radii
        radii v  ==> restores default VMD radii
        radii {c:/path/param_charmm.inp}  ==> reads radii from CHARMM parameters file
        radii {c:/path/raddi_file.txt} r  ==> reads radii from 'type TAB radius' file
ss	starts sscache script recalculating secondary structure for every frame and keeping it
	in the cache for fast use. 
	Usage: ss <molid|top|>. E.g. 'ss', 'ss top', 'ss 2' 
lbl	Labels each atom in the 'selectionText' with information 'labelInfo', with 
	arbitrary prefix 'labelPrefix', color 'color' and font size 'size' (default 1).
	Syntax:  'lbl <|selectionText> <|labelInfo> <|labelPrefix> <|color> <|size>' 
	E.g. 'lbl \{resid 1 to 10 and name CA\}', 
	'lbl \{name CA\} \{resname resid\} \{ \} blue 0.5'

"
}
user add key {=} {
	#goes to the next animation frame
	animate next
}

user add key f {
	#Flips  -  Rotates scene 180 degrees aroynd Y (vertical on screen) axis
	rotate y by 180
}


user add key q {
	#Rotates scene to make a view from X axis, z is up
	mouse stoprotation
	rotate x to -90
	rotate y by -90
}

user add key w {
	#Rotates scene to make a view from Y axis, z is up
	mouse stoprotation
	rotate z to 180
	rotate x by -90
}

user add key e {
	#Rotates scene to make a view from Z axis, x is to the left
	mouse stoprotation
	rotate z to 180
}

user add key o {
	#draws coordinate cylinders in origin
	draw color red
	draw cylinder {-100 0 0} {100 0 0} radius 0.5
	draw cone {2 0 0} {5 0 0} radius 1 resolution 12
	draw color green
	draw cylinder {0 -100 0} {0 100 0} radius 0.5
	draw cone {0 2 0} {0 5 0} radius 1 resolution 12
	draw color blue
	draw cylinder {0 0 -100} {0 0 100} radius 0.5
	draw cone {0 0 2} {0 0 5} radius 1 resolution 12
	
}

user add key d {
	#removes all the graphics added
	draw delete all
}

user add key g {
	draw color red
	draw cylinder {-100 0 0} {100 0 0} radius 0.5
	draw cone {2 0 0} {5 0 0} radius 1 resolution 12
	draw color green
	draw cylinder {0 -100 0} {0 100 0} radius 0.5
	draw cone {0 2 0} {0 5 0} radius 1 resolution 12
	draw color blue
	draw cylinder {0 0 -100} {0 0 100} radius 0.5
	draw cone {0 0 2} {0 0 5} radius 1 resolution 12
	
	for {set i -100} {$i <= 100} {incr i} {
		draw color red
		set v1 "-1 $i 0"
		set v2 "1 $i 0"
		set v3 "-1 0 $i"
		set v4 "1 0 $i"
		draw cylinder $v1 $v2 radius 0.05
		draw cylinder $v3 $v4 radius 0.05
		draw color green
		set v1 "0 -1 $i"
		set v2 "0 1 $i"
		set v3 "$i -1 0"
		set v4 "$i 1 0"
		draw cylinder $v1 $v2 radius 0.05
		draw cylinder $v3 $v4 radius 0.05
		draw color blue
		set v1 "$i 0 -1"
		set v2 "$i 0 1"
		set v3 "0 $i -1"
		set v4 "0 $i 1"
		draw cylinder $v1 $v2 radius 0.05
		draw cylinder $v3 $v4 radius 0.05
	}

	for {set i -20} {$i <= 20} {incr i} {
		draw color red
		set v1 "-100 [expr ($i*5)] 0"
		set v2 "100 [expr ($i*5)] 0"
		set v3 "-100 0 [expr ($i*5)]"
		set v4 "100 0 [expr ($i*5)]"
		draw cylinder $v1 $v2 radius 0.1
		draw cylinder $v3 $v4 radius 0.1
		draw color green
		set v1 "0 -100 [expr ($i*5)]"
		set v2 "0 100 [expr ($i*5)]"
		set v3 "[expr ($i*5)] -100 0"
		set v4 "[expr ($i*5)] 100 0"
		draw cylinder $v3 $v4 radius 0.1
		draw cylinder $v1 $v2 radius 0.1
		draw color blue
		set v1 "[expr ($i*5)] 0 -100"
		set v2 "[expr ($i*5)] 0 100"
		set v3 "0 [expr ($i*5)] -100"
		set v4 "0 [expr ($i*5)] 100"
		draw cylinder $v3 $v4 radius 0.1
		draw cylinder $v1 $v2 radius 0.1
	}

	for {set i -10} {$i <= 10} {incr i} {
		draw color red
		set v1 "-100 [expr ($i*10)] 0"
		set v2 "100 [expr ($i*10)] 0"
		set v3 "-100 0 [expr ($i*10)]"
		set v4 "100 0 [expr ($i*10)]"
		draw cylinder $v1 $v2 radius 0.2
		draw cylinder $v3 $v4 radius 0.2
		draw color green
		set v1 "0 -100 [expr ($i*10)]"
		set v2 "0 100 [expr ($i*10)]"
		set v3 "[expr ($i*10)] -100 0"
		set v4 "[expr ($i*10)] 100 0"
		draw cylinder $v1 $v2 radius 0.2
		draw cylinder $v3 $v4 radius 0.2
		draw color blue
		set v1 "[expr ($i*10)] 0 -100"
		set v2 "[expr ($i*10)] 0 100"
		set v3 "0 [expr ($i*10)] -100"
		set v4 "0 [expr ($i*10)] 100"
		draw cylinder $v3 $v4 radius 0.2
		draw cylinder $v1 $v2 radius 0.2
	}
}




user add key m {
	#Moves geometry center of the molecule to the origin
	[atomselect top all] moveby [vecscale -1.0 [measure center [atomselect top all]]]
}

user add key "`" {
	# Based on the Orient script written by Paul Grayson
	# Orients top molecule (not more than 50,000 atoms) by principal axes (requires Orient script written by Paul Grayson and  linear algebra package by Hume Integration Software)
	if {[[atomselect top all] num] <= 50000} {
		catch {
			set sel [atomselect top "all"]
			set I [draw principalaxes $sel]
			set A [orient $sel [lindex $I 2] {0 0 1}]
			$sel move $A
			set I [draw principalaxes $sel]
			set A [orient $sel [lindex $I 1] {0 1 0}]
			$sel move $A
			set I [draw principalaxes $sel]
		}
	}
}


user add key n {
	#Apply preselected graphical representation
# 	set viewplist {}
# 	set fixedlist {}
	mol delrep 0 top
	#mol representation Cartoon 2.100000 7.000000 5.000000
	#mol color Index
 	mol representation NewRibbons 1.800000 6.000000 2.600000 0
#	mol representation NewRibbons 1.800000 3.000000 2.600000 0
#  	mol representation Trace 0.500000 6.000000
	mol color ResType
	mol color Index
	mol selection {all}
	mol material Opaque
	mol addrep top
	#mol representation Dotted 1.000000 4.000000
	#mol color Index
	#mol selection {all}
	#mol material Opaque
	#mol addrep top
# 	set viewpoints([molinfo top]) {{{1.000000 0.000000 0.000000 -16.698196} {0.000000 1.000000 0.000000 -39.251564} {0.000000 0.000000 1.000000 -6.660641} {0.000000 0.000000 0.000000 1.000000}} {{1.000000 0.000000 0.000000 0.000000} {0.000000 1.000000 0.000000 0.000000} {0.000000 0.000000 1.000000 0.000000} {0.000000 0.000000 0.000000 1.000000}} {{0.023451 0.000000 0.000000 0.000000} {0.000000 0.023451 0.000000 0.000000} {0.000000 0.000000 0.023451 0.000000} {0.000000 0.000000 0.000000 1.000000}} {{1.000000 0.000000 0.000000 0.000000} {0.000000 1.000000 0.000000 0.000000} {0.000000 0.000000 1.000000 0.000000} {0.000000 0.000000 0.000000 1.000000}}}
# 	lappend viewplist [molinfo top]
# 	set topmol [molinfo top]
	# done with molecule 0
# 	foreach v $viewplist {
# 	  molinfo $v set {center_matrix rotate_matrix scale_matrix
# 	global_matrix} $viewpoints($v)
# 	}
# 	foreach v $fixedlist {
# 	  molinfo $v set fixed 1
# 	}
# 	unset viewplist
# 	unset fixedlist
# 	mol top $topmol
# 	unset topmol
	#color Chain {X} blue
	#color Segname {} blue
	#color Molecule {C:/Andrey/Mechanosensing/Structure/Membrane_Proteins_of_Known_Structure/PDB_protein_only/1AP9_prt.pdb:000} blue
# 	color Surface {Grasp} gray
# 	color change rgb 0 0.0 0.0 1.0
# 	color change rgb 2 0.34999999404 0.34999999404 0.34999999404
# 	color change rgb 3 1.0 0.5 0.0
# 	color change rgb 4 1.0 1.0 0.0
# 	color change rgb 5 0.5 0.5 0.20000000298
# 	color change rgb 6 0.600000023842 0.600000023842 0.600000023842
# 	color change rgb 7 0.0 1.0 0.0
# 	color change rgb 9 1.0 0.600000023842 0.600000023842
# 	color change rgb 11 0.649999976158 0.0 0.649999976158
# 	color change rgb 12 0.5 0.899999976158 0.40000000596
# 	color change rgb 13 0.899999976158 0.40000000596 0.699999988079
# 	color change rgb 14 0.5 0.300000011921 0.0
# 	color change rgb 15 0.5 0.5 0.75
# 	color change rgb 16 1.0 1.0 1.0

# 	display resetview
# 	scale by 1.8

}

user add key i {
	#Apply preselected graphical representation
	mol delrep 0 top
  	mol representation Trace 0.500000 6.000000
	mol color ResType
	mol color Index
	mol selection {all}
	mol material Opaque
	mol addrep top
}

user add key 0 {
	mouse mode 4 0
	menu labels on
}


user add key v {
	#sets white background and exp2 depth cue
	color Display {Background} white
	
	display depthcue   off
	display cuestart   0.500000
	display cueend     10.000000
	display cuedensity 0.120000
	display cuemode    Exp2
}

user add key b {
	#sets black background without depthcue
	color Display {Background} black
	
	display depthcue   off
}

user add key p {
	#switches depthcue on and off
	if {[string compare [display get depthcue] on] == 0} {
		#Switch depthcue off
		display depthcue off
	} {
		#Switch depthcue on
		display depthcue   off
# 		display cuestart   0.500000
# 		display cueend     10.000000
# 		display cuedensity 0.120000
# 		display cuemode    Exp2
	}

}


user add key u {
	#makes the selections of the top molecule to auto update each frame
	set n [molinfo top get numreps]
	for {set i 0} {$i < $n} {incr i} {
	    mol selupdate $i top on
	}
}

user add key a {
	# Applies representations from the top molecule to all other molecules
	# based on save_state script by John Stone
  set srcmol [molinfo top]
  foreach mol [molinfo list] {
    if {$mol == $srcmol} continue
    #delete current representations
    set numreps [molinfo $mol get numreps]
    for {set i 0} {$i < $numreps} {incr i} {
      mol delrep 0 $mol
    }
  }
  for {set i 0} {$i < [molinfo $srcmol get numreps]} {incr i} {
    set rep [molinfo $srcmol get "{rep $i} {selection $i} {color $i} {material $i}"]
    lappend rep [mol showperiodic $srcmol $i]
    lappend rep [mol numperiodic $srcmol $i]
    lappend rep [mol showrep $srcmol $i]
    lappend rep [mol selupdate $i $srcmol]
    lappend rep [mol colupdate $i $srcmol]
    lappend rep [mol scaleminmax $srcmol $i]
    lappend rep [mol smoothrep $srcmol $i]
    lappend rep [mol drawframes $srcmol $i]
    foreach mol [molinfo list] {
      if {$mol == $srcmol} continue
      foreach {r s c m pbc numpbc on selupd colupd colminmax smooth framespec} $rep { break }
      eval "mol representation $r"
      eval "mol color $c"
      eval "mol selection {$s}"
      eval "mol material $m"
      eval "mol addrep $mol"
      if {[string length $pbc]} {
        eval "mol showperiodic $mol $i $pbc"
        eval "mol numperiodic $mol $i $numpbc"
      }
      eval "mol selupdate $i $mol $selupd"
      eval "mol colupdate $i $mol $colupd"
      eval "mol scaleminmax $mol $i $colminmax"
      eval "mol smoothrep $mol $i $smooth"
      eval "mol drawframes $mol $i {$framespec}"
      if { !$on } {
        eval "mol showrep $mol $i 0"
      }
    }
  }
}


# #Prepares newer version of Tcl console for loading. The file should be in VMD folder
# source {C:/Program Files/University of Illinois/VMD/tkcon_AGA.tcl}

# #(there is no pkgIndex.tcl for it)
# package require tkcon
# #tkcon show

#vmdtkcon

user add key {;} {
	#Calls tkcon console window to the top (after it was once started from the VMD menu)
	tkcon show
}

user add key {'} {
		menu graphics on
}

user add key {[} {
		menu main on
}

user add key {]} {
		#Preocedure sets current working folder to the path to the last loaded file of the top molecule
		catch {cd [file dirname [lindex [lindex [molinfo top get filename] 0] end]]}
		pwd
		menu files on
}

user add key "\\" {
		menu sequence on
}

user add key {r} {
	mouse stoprotation
	mouse mode 0 0
}

proc write_vector { vec filename } {
  set fid [open $filename w]
  foreach elem $vec { puts $fid $elem }
  close $fid
}


proc fx { } {
		# Rotate (flip) protein 180 degrees around x axis
		[atomselect top all] move [transaxis x 180]
}
proc fy { } {
		# Rotate (flip) protein 180 degrees around y axis
		[atomselect top all] move [transaxis y 180]
}
proc fz { } {
		# Rotate (flip) protein 180 degrees around z axis
		[atomselect top all] move [transaxis z 180]
}

# define a new, very transparent material 'Glass'
material add Glass
material change ambient   Glass 0.00
material change specular  Glass 0.50
material change diffuse   Glass 0.65
material change shininess Glass 0.53
material change opacity   Glass 0.15


# define a new, semitransparent strictly white material 'Slice', for making protein crossection pictures
material add Slice
material change ambient   Slice 1.00
material change specular  Slice 0.00
material change diffuse   Slice 1.00
material change shininess Slice 0.00
material change opacity   Slice 0.75

# define a new, non-shiny white material 'Gypsum', for making BW protein pictures
material add Gypsum
material change ambient Gypsum 0.000000
material change specular Gypsum 1.000000
material change diffuse Gypsum 1.000000
material change shininess Gypsum 0.000000
material change opacity Gypsum 1.000000

# define a new, non-shiny gray material 'Smog', for making BW protein crossections
material add Smog
material change ambient Smog 0.400000
material change specular Smog 0.000000
material change diffuse Smog 0.000000
material change shininess Smog 0.000000
material change opacity Smog 1.000000

# Atom selection macros
atomselect macro ceramide {resname CER "C[0-9]*"}
atomselect macro cer ceramide
atomselect macro c ceramide
atomselect macro p protein
atomselect macro l {lipid or resname OCT}
atomselect macro i ions
atomselect macro w {resname SOL TIP TIP3 TP3M TP3E TP3P TIP4 TIP5 ST2 SPC WAT H2O WTR}




proc colstart {} {
	# Based on Justin Gullingsrud's vmdcollab script 
	# Starts collaboration session between two VMD machines
	# ====== Source of the vmdcollab.tcl and bounce.tcl scripts
	# vmdcollab
	# 8-23-2000 by Justin Gullingsrud, based on echo server from Welch, 3rd ed.
	#
	# vmdcollab: let two or more VMD's broadcast their commands to each other.
	# This allows, for example, mouse rotations in one VMD to be reflected in
	# all the other VMD's.  
	#
	# Start the chat session with the command vmdcollab::start <host> <port>
	# VMD will try to connect to a server on the given host and port.  Once
	# connected, all commands issued by VMD that have text equivalents will be
	# sent to the server, which is then expected to forward the text commands
	# to the other VMD's (but _not_ back to the originator).  
	# 
	# Important trick: the chat client avoids endless bouncing of messages by
	# turning off broadcasts while an incoming command is being evaluated.
	# 
	# The server in bounce.tcl can serve as the chat host, and can even run
	# in the same Tcl interpreter as a chat client.
	
	namespace eval vmdcollab {
	  variable chatsock
	  variable broadcast 
	
	  proc start { host port } {
	    variable chatsock 
	    variable broadcast 
	
	    set chatsock [socket $host $port]
	    fconfigure $chatsock -buffering line
	    fileevent $chatsock readable [list vmdcollab::recv $chatsock]
	    set broadcast 1 
	
	    # Assume that text will be placed in the global variable vmd_logfile
	    uplevel #0 trace variable vmd_logfile w vmdcollab::send 
	  }
	 
	  proc stop { } {
	    variable chatsock
	    puts "closing connection"
	    close $chatsock
	    trace vdelete vmd_logfile w vmdcollab::send
	    return
	  }
	 
	  proc recv { sock } {
	    variable broadcast
	    if { [eof $sock] || [catch {gets $sock line}]} {
	      # end of file or abnormal connection drop
	      puts "closing connection"
	      close $sock
	      trace vdelete vmd_logfile w vmdcollab::send
	      return
	    }
	    # Turn off broadcast while evaluating, otherwise we would echo every
	    # command we receive.
	    set broadcast 0 
	    eval $line 
	    set broadcast 1
	  }
	
	  proc send { name1 name2 op } {
	    variable broadcast
	    variable chatsock
	
	    if { $broadcast == 0 } { return }
	    # Grab the text out of vmd_logfile and send it
	    upvar #0 vmd_logfile line
	    puts $chatsock $line
	  }
	}
	
	   
	
	# This is a server that bounces all received lines of text to 
	# all clients (except the one that sent the text).
	
	namespace eval bounce {
	  variable main
	  variable clients
	  variable logfile
	
	  proc start { port } {
	    variable main
	    set main [socket -server bounce::acpt $port]  
	    putlog "Listening on port $port"
	  }
	
	  proc acpt { sock addr port } {
	    variable clients
	    putlog "Accept $sock from $addr port $port"
	    set clients($sock) 1
	    fconfigure $sock -buffering line
	    fileevent $sock readable [list bounce::recv $sock]
	  }
	
	  proc recv { sock } {
	    variable main
	    variable clients
	    if { [eof $sock] || [catch {gets $sock line}]} {
	      # end of file or abnormal connection drop
	      close $sock
	      putlog "Closing $sock"
	      unset clients($sock)
	    } else {
	      if {[string compare $line "quit"] == 0} {
	        # prevent new connections
	        # existing connections stay open
	        putlog "Disallowing incoming connections by request of $sock"
	        close $main 
	      }
	      send $sock $line  
	    }
	  }
	 
	  proc send { sock line } {
	    variable clients
	    foreach client [array name clients] {
	      if { [string compare $sock $client] != 0 } { # don't send to originator
	#        putlog "send '$line' to $client"
	        puts $client $line
	      }
	    }
	  }
	 
	  proc putlog { text } {
	    puts $text
	    return
	  }
	}
	 
	
	# start bounce server
	catch {bounce::start 25}
# 	vmdcollab::start 129.2.38.196 25
 	vmdcollab::start 129.2.36.16 25
#  	vmdcollab::start 129.2.38.10 25
}


proc colstop {} {
	# Stops collaboration session between two VMD machines
	# Based on Justin Gullingsrud's vmdcollab script 
	vmdcollab::stop
}

                
# Set Resname colors
color Resname ALA gray
color Resname ARG blue
color Resname ASN green
color Resname ASP red
color Resname CYS yellow
color Resname GLY black
color Resname GLU red
color Resname GLN lime
color Resname HIS mauve
color Resname ILE white
color Resname LEU white
color Resname LYS blue
color Resname MET orange
color Resname PHE pink
color Resname PRO cyan
color Resname SER tan
color Resname THR ochre
color Resname TRP purple
color Resname TYR purple
color Resname VAL silver
# color Resname ADE tan
# color Resname CYT tan
# color Resname GUA tan
# color Resname THY tan
# color Resname URA tan
color Resname TIP iceblue
color Resname TIP3 iceblue
color Resname TP3E iceblue
color Resname WAT iceblue
color Resname SOL iceblue
color Resname H2O iceblue
# color Resname TP3M iceblue
# color Resname TP3E iceblue
# color Resname TP3P iceblue
# color Resname TIP4 iceblue
# color Resname TIP5 iceblue
# color Resname ST2 iceblue
# color Resname SPC iceblue
# color Resname WTR iceblue
# color Resname LYR 
color Resname ZN blue
color Resname NA blue
color Resname CL red
color Resname CLA red
color Resname POT red
color Resname SOD red

# color change rgb 14 0.5 0.300000011921 0.0
proc vmdrestoremycolors {} {
	color change rgb 15 0.6 0.8 1.0
 	color Restype iceblue {Solvent} 
	color Restype yellow {Unassigned} 
}
vmdrestoremycolors

# 		{scale	Guy	Privalov	Eisenberg	White_if	White}
# 		{ALA	0.100 	1	  0.620 	0.17	0.50}
# 		{ARG	1.910 	2	 -2.530 	0.81	1.81}
# 		{ASN	0.480 	1	 -0.780 	0.42	0.85}
# 		{ASP	0.780 	2	 -0.900 	1.23	3.64}
# 		{CYS	-1.420	1	  0.290 	-0.24	-0.02}
# 		{GLY	0.950 	2	 -0.850 	0.58	0.77}
# 		{GLU	0.830 	1	 -0.740 	2.02	3.63}
# 		{GLN	0.330 	2	  0.480 	0.01	1.15}
# 		{HIS	-0.500	1	 -0.400 	0.96	2.33}
# 		{ILE	-1.130	2	  1.380 	-0.31	-1.12}
# 		{LEU	-1.180	1	  1.060 	-0.56	-1.25}
# 		{LYS	1.400 	2	 -1.500 	0.99	2.80}
# 		{MET	-1.590	1	  0.640 	-0.23	-0.67}
# 		{PHE	-2.120	2	  1.190 	-1.13	-1.71}
# 		{PRO	0.730 	1	  0.120 	0.45	0.14}
# 		{SER	0.520 	2	 -0.180 	0.13	0.46}
# 		{THR	0.070 	1	 -0.050 	0.14	0.25}
# 		{TRP	-0.510	2	  0.810 	-1.85	-2.09}
# 		{TYR	-0.210	1	  0.260 	-0.94	-0.71}
# 		{VAL	-1.270	2	  1.080 	0.07	-0.46}

proc bs {args} {
	# Sets beta value of protein residues to the value found in the selected hydrophobicity scale
	if { ![llength $args] } {
		set scale help
	} else {
		set scale $args
	}
	betascale $scale
}

proc betascale {args} {
	if { ![llength $args] } {
		set scale help
	} else {
		if {[llength [lindex $args 0]]>1} {
			set args [lindex $args 0]
		}
		set scale [lindex $args 0]
		if {[llength $args]==2} {
			# Some options provided
			set opt [lindex $args 1]
		} else {
			set opt "none"
		}
	}

	# Sets beta value of protein residues to the value found in the selected hydrophobicity scale
	[atomselect top all] set beta 0
	
	# Define values for all the hydrophobicity scales
	switch [string tolower $scale] {
		{} -
		{-h} -
		{help} {
			puts {
_____________________Amino Acid Property Scales:______________________
AA_Composition	---Overall amino acid composition (%). 	(McCaldon P., Argos P.)
AA_SwissProt	---Amino acid composition (%) in the Swiss-Prot Protein Sequence
			 data bank. 	(Bairoch A.)
AccessibleResidues	---Molar fraction (%) of 3220 accessible residues. 	
			(Janin J.)
AlphaHelix_Fasman	---Amino acid scale: Conformational parameter for alpha 
			helix (computed from 29 proteins). 	
			( Chou P.Y., Fasman G.D.)
AlphaHelix_Levitt	---Normalized frequency for alpha helix. 	
			(Levitt M.)
AlphaHelix_Roux	---Conformational parameter for alpha helix. 	
			(Deleage G., Roux B.)
AntiparallelBetaStrand	---Conformational preference for antiparallel beta 
			strand. 	(Lifson S., Sander C.)
AverageBuried	---Average area buried on transfer from standard state to folded
			 protein. 	(Rose G.D., Geselowitz A.R., 
			 Lesser G.J., Lee R.H., Zehfus M.H.)
AverageFlexibility	---Average flexibility index. 	
			(Bhaskaran R., Ponnuswamy P.K.)
BetaSheet_Fasman	---Conformational parameter for beta-sheet (computed 
			from 29 proteins). 	(Chou P.Y., Fasman G.D.)
BetaSheet_Levitt	---Normalized frequency for beta-sheet. 	
			(Levitt M.)
BetaSheet_Roux	---Conformational parameter for beta-sheet. 	
			(Deleage G., Roux B.)
BetaTurn_Fasman	---Conformational parameter for beta-turn 
			(computed from 29 proteins). 	(Chou P.Y., Fasman G.D.)
BetaTurn_Levitt	---Normalized frequency for beta-turn. 	(Levitt M.)
BetaTurn_Roux	---Conformational parameter for beta-turn. 	
			(Deleage G., Roux B.)
Bulkiness	---Bulkiness. 	(Zimmerman J.M., Eliezer N., Simha R.)
BuriedResidues	---Molar fraction (%) of 2001 buried residues. 	(Janin J.)
Coil_Roux	---Conformational parameter for coil. 	(Deleage G., Roux B.)
Hphob_Argos	---Membrane buried helix parameter. 	(Rao M.J.K., Argos P.)
Hphob_Black	---Amino acid scale: Hydrophobicity of physiological L-alpha 
			amino acids 	( Black S.D., Mould D.R.)
Hphob_Breese	---Hydrophobicity (free energy of transfer to surface in 
			kcal/mole). 	(Bull H.B., Breese K.)
Hphob_Chothia	---Proportion of residues 95% buried (in 12 proteins). 	
			(Chothia C.)
Hphob_Doolittle	---Hydropathicity. 	(Kyte J., Doolittle R.F.)
Hphob_Eisenberg	---Normalized consensus hydrophobicity scale. 	
			(Eisenberg D., Schwarz E., Komarony M., Wall R.)
Hphob_Fauchere	---Hydrophobicity scale (pi-r). 	
			(Fauchere J.-L., Pliska V.E.)
Hphob_Guy	---Hydrophobicity scale based on free energy of transfer 
			(kcal/mole). 	(Guy H.R.)
Hphob_Janin	---Free energy of transfer from inside to outside of a globular 
			protein. 	(Janin J.)
Hphob_Leo	---Amino acid scale: Hydrophobicity (delta G1/2 cal) 	
			( Abraham D.J., Leo A.J.)
Hphob_Manavalan	---Average surrounding hydrophobicity. 	
			(Manavalan P., Ponnuswamy P.K.)
Hphob_Miyazawa	---Hydrophobicity scale (contact energy derived from 3D data). 	
			(Miyazawa S., Jernigen R.L.)
Hphob_mobility	---Mobilities of amino acids on chromatography paper (RF). 	
			(Aboderin A.A.)
Hphob_Parker	---Hydrophilicity scale derived from HPLC peptide retention 
			times. 	(Parker J.M.R., Guo D., Hodges R.S.)
Hphob_pH3.4	---Hydrophobicity indices at ph 3.4 determined by HPLC. 	
			(Cowan R., Whittaker R.G.)
Hphob_pH7.5	---Hydrophobicity indices at ph 7.5 determined by HPLC. 	
			(Cowan R., Whittaker R.G.)
Hphob_Rose	---Mean fractional area loss (f) [average area buried/standard 
			state area]. 	(Rose G.D., Geselowitz A.R., 
			Lesser G.J., Lee R.H., Zehfus M.H.)
Hphob_Roseman	---Hydrophobicity scale (pi-r). 	(Roseman M.A.)
Hphob_Sweet	---Optimized matching hydrophobicity (OMH). 	
			(Sweet R.M., Eisenberg D.)
Hphob_Welling	---Antigenicity value X 10. 	(Welling G.W., Weijer W.J., 
			Van der Zee R., Welling-Wester S.)
Hphob_Wilson	---Hydrophobic constants derived from HPLC peptide retention 
			times. 	
			(Wilson K.J., Honegger A., Stotzel R.P., Hughes G.J.)
Hphob_Wolfenden	---Hydration potential (kcal/mole) at 25øC. 	(Wolfenden R.V.,
			 Andersson L., Cullis P.M., Southgate C.C.F.)
Hphob_Woods	---Hydrophilicity. 	(Hopp T.P., Woods K.R.)
HPLC2.1	---Retention coefficient in HPLC, pH 2.1. 	(Meek J.L.)
HPLC7.4	---Retention coefficient in HPLC, pH 7.4. 	(Meek J.L.)
HPLCHFBA	---Retention coefficient in HFBA. 	
			(Browne C.A., Bennett H.P.J., Solomon S.)
HPLCTFA	---Retention coefficient in TFA. 	
			(Browne C.A., Bennett H.P.J., Solomon S.)
MolecularWeight	---Molecular weight of each amino acid. 	
NumberCodons	---Number of codon(s) coding for each amino acid in universal 
			genetic code. 	
ParallelBetaStrand	---Amino acid scale: Conformational preference for 
			parallel beta strand. 	( Lifson S., Sander C.)
Polarity_Grantham	---Polarity (p). 	(Grantham R.)
Polarity_Zimmerman	---Polarity. 	(Zimmerman J.M., Eliezer N., Simha R.)
RatioSide	---Atomic weight ratio of hetero elements in end group to C in 
			side chain. 	(Grantham R.)
RecognitionFactors	---Recognition factors. 	(Fraga S.)
Refractivity	---Refractivity. 	(Jones. D.D.)
RelativeMutability	---Relative mutability of amino acids (Ala=100).
			(Dayhoff M.O., Schwartz R.M., Orcutt B.C.)
TotalBetaStrand	---Conformational preference for total beta strand 
			(antiparallel+parallel). 	(Lifson S., Sander C.)
Hphob_Privalov_dCp	---deltaCp hydration, J/(K*mol*A^2),
			(Privalov, P. L. & Khechinashvili, N. N.)
Hphob_Privalov_dH	---deltaH hydration, J/(mol*A^2), 25 oC
			(Privalov, P. L. & Khechinashvili, N. N.)
Hphob_Privalov_dS	---deltaS hydration, J/(K*mol*A^2), 25 oC
			(Privalov, P. L. & Khechinashvili, N. N.)
Hphob_Privalov_dG	---deltaG hydration, J/(mol*A^2), 25 oC
			(Privalov, P. L. & Khechinashvili, N. N.)
			}
			return
		}
		custom {
			# Custom Amino acid scale	Insert any values 
			set wholeScale {
				{Ala	1}
				{Arg	2}
				{Asn	1}
				{Asp	2}
				{Cys	1}
				{Gln	2}
				{Glu	1}
				{Gly	2}
				{His	1}
				{Ile	2}
				{Leu	1}
				{Lys	2}
				{Met	1}
				{Phe	2}
				{Pro	1}
				{Ser	2}
				{Thr	1}
				{Trp	2}
				{Tyr	1}
				{Val	2}
			}
		}


		aa_composition {
			# Amino acid scale	Overall amino acid composition (%). 
			# Author(s)	McCaldon P., Argos P. 
			# Reference	Proteins	Structure, Function and Genetics 4	99-122(1988). 
			# Amino acid scale values
			set wholeScale {
				{Ala	8.300}
				{Arg	5.700}
				{Asn	4.400}
				{Asp	5.300}
				{Cys	1.700}
				{Gln	4.000}
				{Glu	6.200}
				{Gly	7.200}
				{His	2.200}
				{Ile	5.200}
				{Leu	9.000}
				{Lys	5.700}
				{Met	2.400}
				{Phe	3.900}
				{Pro	5.100}
				{Ser	6.900}
				{Thr	5.800}
				{Trp	1.300}
				{Tyr	3.200}
				{Val	6.600}
			}
		}
		
		aa_swissprot {
			# Amino acid scale	Amino acid composition (%) in the Swiss-Prot Protein Sequence data bank. 
			# Author(s)	Bairoch A. 
			# Reference	Release notes for Swiss-Prot release 41 - February 2003. 
			# Amino acid scale values
			set wholeScale {
				{Ala	7.720}
				{Arg	5.240}
				{Asn	4.280}
				{Asp	5.270}
				{Cys	1.600}
				{Gln	3.920}
				{Glu	6.540}
				{Gly	6.900}
				{His	2.260}
				{Ile	5.880}
				{Leu	9.560}
				{Lys	5.960}
				{Met	2.360}
				{Phe	4.060}
				{Pro	4.880}
				{Ser	6.980}
				{Thr	5.580}
				{Trp	1.180}
				{Tyr	3.130}
				{Val	6.660}
			}
		}
		
		accessibleresidues {
			# Amino acid scale	Molar fraction (%) of 3220 accessible residues. 
			# Author(s)	Janin J. 
			# Reference	Nature 277	491-492(1979). 
			# Amino acid scale values
			set wholeScale {
				{Ala	6.600}
				{Arg	4.500}
				{Asn	6.700}
				{Asp	7.700}
				{Cys	0.900}
				{Gln	5.200}
				{Glu	5.700}
				{Gly	6.700}
				{His	2.500}
				{Ile	2.800}
				{Leu	4.800}
				{Lys	10.300}
				{Met	1.000}
				{Phe	2.400}
				{Pro	4.800}
				{Ser	9.400}
				{Thr	7.000}
				{Trp	1.400}
				{Tyr	5.100}
				{Val	4.500}
			}
		}
		
		alphahelix_fasman {
			# Amino acid scale: Conformational parameter for alpha helix (computed from 29 proteins). 
			# Author(s): Chou P.Y., Fasman G.D. 
			# Reference: Adv. Enzym. 47:45-148(1978). 
			# Amino acid scale values:
			set wholeScale {
				{Ala	1.420}
				{Arg	0.980}
				{Asn	0.670}
				{Asp	1.010}
				{Cys	0.700}
				{Gln	1.110}
				{Glu	1.510}
				{Gly	0.570}
				{His	1.000}
				{Ile	1.080}
				{Leu	1.210}
				{Lys	1.160}
				{Met	1.450}
				{Phe	1.130}
				{Pro	0.570}
				{Ser	0.770}
				{Thr	0.830}
				{Trp	1.080}
				{Tyr	0.690}
				{Val	1.060}
			}
		}
		
		alphahelix_levitt {
			# Amino acid scale	Normalized frequency for alpha helix. 
			# Author(s)	Levitt M. 
			# Reference	Biochemistry 17	4277-4285(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.290}
				{Arg	0.960}
				{Asn	0.900}
				{Asp	1.040}
				{Cys	1.110}
				{Gln	1.270}
				{Glu	1.440}
				{Gly	0.560}
				{His	1.220}
				{Ile	0.970}
				{Leu	1.300}
				{Lys	1.230}
				{Met	1.470}
				{Phe	1.070}
				{Pro	0.520}
				{Ser	0.820}
				{Thr	0.820}
				{Trp	0.990}
				{Tyr	0.720}
				{Val	0.910}
			}
		}
		
		alphahelix_roux {
			# Amino acid scale	Conformational parameter for alpha helix. 
			# Author(s)	Deleage G., Roux B. 
			# Reference	Protein Engineering 1	289-294(1987). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.489}
				{Arg	1.224}
				{Asn	0.772}
				{Asp	0.924}
				{Cys	0.966}
				{Gln	1.164}
				{Glu	1.504}
				{Gly	0.510}
				{His	1.003}
				{Ile	1.003}
				{Leu	1.236}
				{Lys	1.172}
				{Met	1.363}
				{Phe	1.195}
				{Pro	0.492}
				{Ser	0.739}
				{Thr	0.785}
				{Trp	1.090}
				{Tyr	0.787}
				{Val	0.990}
			}
		}
		
		antiparallelbetastrand {
			# Amino acid scale	Conformational preference for antiparallel beta strand. 
			# Author(s)	Lifson S., Sander C. 
			# Reference	Nature 282	109-111(1979). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.900}
				{Arg	1.020}
				{Asn	0.620}
				{Asp	0.470}
				{Cys	1.240}
				{Gln	1.180}
				{Glu	0.620}
				{Gly	0.560}
				{His	1.120}
				{Ile	1.540}
				{Leu	1.260}
				{Lys	0.740}
				{Met	1.090}
				{Phe	1.230}
				{Pro	0.420}
				{Ser	0.870}
				{Thr	1.300}
				{Trp	1.750}
				{Tyr	1.680}
				{Val	1.530}
			}
		}
		
		averageburied {
			# Amino acid scale	Average area buried on transfer from standard state to folded protein. 
			# Author(s)	Rose G.D., Geselowitz A.R., Lesser G.J., Lee R.H., Zehfus M.H. 
			# Reference	Science 229	834-838(1985). 
			# Amino acid scale values
			set wholeScale {
				{Ala	86.600}
				{Arg	162.200}
				{Asn	103.300}
				{Asp	97.800}
				{Cys	132.300}
				{Gln	119.200}
				{Glu	113.900}
				{Gly	62.900}
				{His	155.800}
				{Ile	158.000}
				{Leu	164.100}
				{Lys	115.500}
				{Met	172.900}
				{Phe	194.100}
				{Pro	92.900}
				{Ser	85.600}
				{Thr	106.500}
				{Trp	224.600}
				{Tyr	177.700}
				{Val	141.000}
			}
		}
		
		averageflexibility {
			# Amino acid scale	Average flexibility index. 
			# Author(s)	Bhaskaran R., Ponnuswamy P.K. 
			# Reference	Int. J. Pept. Protein. Res. 32	242-255(1988). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.360}
				{Arg	0.530}
				{Asn	0.460}
				{Asp	0.510}
				{Cys	0.350}
				{Gln	0.490}
				{Glu	0.500}
				{Gly	0.540}
				{His	0.320}
				{Ile	0.460}
				{Leu	0.370}
				{Lys	0.470}
				{Met	0.300}
				{Phe	0.310}
				{Pro	0.510}
				{Ser	0.510}
				{Thr	0.440}
				{Trp	0.310}
				{Tyr	0.420}
				{Val	0.390}
			}
		}
		
		betasheet_fasman {
			# Amino acid scale	Conformational parameter for beta-sheet (computed from 29 proteins). 
			# Author(s)	Chou P.Y., Fasman G.D. 
			# Reference	Adv. Enzym. 47	45-148(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.830}
				{Arg	0.930}
				{Asn	0.890}
				{Asp	0.540}
				{Cys	1.190}
				{Gln	1.100}
				{Glu	0.370}
				{Gly	0.750}
				{His	0.870}
				{Ile	1.600}
				{Leu	1.300}
				{Lys	0.740}
				{Met	1.050}
				{Phe	1.380}
				{Pro	0.550}
				{Ser	0.750}
				{Thr	1.190}
				{Trp	1.370}
				{Tyr	1.470}
				{Val	1.700}
			}
		}
		
		betasheet_levitt {
			# Amino acid scale	Normalized frequency for beta-sheet. 
			# Author(s)	Levitt M. 
			# Reference	Biochemistry 17	4277-4285(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.900}
				{Arg	0.990}
				{Asn	0.760}
				{Asp	0.720}
				{Cys	0.740}
				{Gln	0.800}
				{Glu	0.750}
				{Gly	0.920}
				{His	1.080}
				{Ile	1.450}
				{Leu	1.020}
				{Lys	0.770}
				{Met	0.970}
				{Phe	1.320}
				{Pro	0.640}
				{Ser	0.950}
				{Thr	1.210}
				{Trp	1.140}
				{Tyr	1.250}
				{Val	1.490}
			}
		}
		
		betasheet_roux {
			# Amino acid scale	Conformational parameter for beta-sheet. 
			# Author(s)	Deleage G., Roux B. 
			# Reference	Protein Engineering 1	289-294(1987). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.709}
				{Arg	0.920}
				{Asn	0.604}
				{Asp	0.541}
				{Cys	1.191}
				{Gln	0.840}
				{Glu	0.567}
				{Gly	0.657}
				{His	0.863}
				{Ile	1.799}
				{Leu	1.261}
				{Lys	0.721}
				{Met	1.210}
				{Phe	1.393}
				{Pro	0.354}
				{Ser	0.928}
				{Thr	1.221}
				{Trp	1.306}
				{Tyr	1.266}
				{Val	1.965}
			}
		}
		
		betaturn_fasman {
			# Amino acid scale	Conformational parameter for beta-turn (computed from 29 proteins). 
			# Author(s)	Chou P.Y., Fasman G.D. 
			# Reference	Adv. Enzym. 47	45-148(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.660}
				{Arg	0.950}
				{Asn	1.560}
				{Asp	1.460}
				{Cys	1.190}
				{Gln	0.980}
				{Glu	0.740}
				{Gly	1.560}
				{His	0.950}
				{Ile	0.470}
				{Leu	0.590}
				{Lys	1.010}
				{Met	0.600}
				{Phe	0.600}
				{Pro	1.520}
				{Ser	1.430}
				{Thr	0.960}
				{Trp	0.960}
				{Tyr	1.140}
				{Val	0.500}
			}
		}
		
		betaturn_levitt {
			# Amino acid scale	Normalized frequency for beta-turn. 
			# Author(s)	Levitt M. 
			# Reference	Biochemistry 17	4277-4285(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.770}
				{Arg	0.880}
				{Asn	1.280}
				{Asp	1.410}
				{Cys	0.810}
				{Gln	0.980}
				{Glu	0.990}
				{Gly	1.640}
				{His	0.680}
				{Ile	0.510}
				{Leu	0.580}
				{Lys	0.960}
				{Met	0.410}
				{Phe	0.590}
				{Pro	1.910}
				{Ser	1.320}
				{Thr	1.040}
				{Trp	0.760}
				{Tyr	1.050}
				{Val	0.470}
			}
		}
		
		betaturn_roux {
			# Amino acid scale	Conformational parameter for beta-turn. 
			# Author(s)	Deleage G., Roux B. 
			# Reference	Protein Engineering 1	289-294(1987). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.788}
				{Arg	0.912}
				{Asn	1.572}
				{Asp	1.197}
				{Cys	0.965}
				{Gln	0.997}
				{Glu	1.149}
				{Gly	1.860}
				{His	0.970}
				{Ile	0.240}
				{Leu	0.670}
				{Lys	1.302}
				{Met	0.436}
				{Phe	0.624}
				{Pro	1.415}
				{Ser	1.316}
				{Thr	0.739}
				{Trp	0.546}
				{Tyr	0.795}
				{Val	0.387}
			}
		}
		
		bulkiness {
			# Amino acid scale	Bulkiness. 
			# Author(s)	Zimmerman J.M., Eliezer N., Simha R. 
			# Reference	J. Theor. Biol. 21	170-201(1968). 
			# Amino acid scale values
			set wholeScale {
				{Ala	11.500}
				{Arg	14.280}
				{Asn	12.820}
				{Asp	11.680}
				{Cys	13.460}
				{Gln	14.450}
				{Glu	13.570}
				{Gly	3.400}
				{His	13.690}
				{Ile	21.400}
				{Leu	21.400}
				{Lys	15.710}
				{Met	16.250}
				{Phe	19.800}
				{Pro	17.430}
				{Ser	9.470}
				{Thr	15.770}
				{Trp	21.670}
				{Tyr	18.030}
				{Val	21.570}
			}
		}
		
		buriedresidues {
			# Amino acid scale	Molar fraction (%) of 2001 buried residues. 
			# Author(s)	Janin J. 
			# Reference	Nature 277	491-492(1979). 
			# Amino acid scale values
			set wholeScale {
				{Ala	11.200}
				{Arg	0.500}
				{Asn	2.900}
				{Asp	2.900}
				{Cys	4.100}
				{Gln	1.600}
				{Glu	1.800}
				{Gly	11.800}
				{His	2.000}
				{Ile	8.600}
				{Leu	11.700}
				{Lys	0.500}
				{Met	1.900}
				{Phe	5.100}
				{Pro	2.700}
				{Ser	8.000}
				{Thr	4.900}
				{Trp	2.200}
				{Tyr	2.600}
				{Val	12.900}
			}
		}
		
		coil_roux {
			# Amino acid scale	Conformational parameter for coil. 
			# Author(s)	Deleage G., Roux B. 
			# Reference	Protein Engineering 1	289-294(1987). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.824}
				{Arg	0.893}
				{Asn	1.167}
				{Asp	1.197}
				{Cys	0.953}
				{Gln	0.947}
				{Glu	0.761}
				{Gly	1.251}
				{His	1.068}
				{Ile	0.886}
				{Leu	0.810}
				{Lys	0.897}
				{Met	0.810}
				{Phe	0.797}
				{Pro	1.540}
				{Ser	1.130}
				{Thr	1.148}
				{Trp	0.941}
				{Tyr	1.109}
				{Val	0.772}
			}
		}
		
		hphob_argos {
			# Amino acid scale	Membrane buried helix parameter. 
			# Author(s)	Rao M.J.K., Argos P. 
			# Reference	Biochim. Biophys. Acta 869	197-214(1986). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.360}
				{Arg	0.150}
				{Asn	0.330}
				{Asp	0.110}
				{Cys	1.270}
				{Gln	0.330}
				{Glu	0.250}
				{Gly	1.090}
				{His	0.680}
				{Ile	1.440}
				{Leu	1.470}
				{Lys	0.090}
				{Met	1.420}
				{Phe	1.570}
				{Pro	0.540}
				{Ser	0.970}
				{Thr	1.080}
				{Trp	1.000}
				{Tyr	0.830}
				{Val	1.370}
			}
		}
		
		hphob_black {
			# Amino acid scale: Hydrophobicity of physiological L-alpha amino acids 
			# Author(s): Black S.D., Mould D.R. 
			# Reference	Anal. Biochem. 193	72-82(1991). . 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.616}
				{Arg	0.000}
				{Asn	0.236}
				{Asp	0.028}
				{Cys	0.680}
				{Gln	0.251}
				{Glu	0.043}
				{Gly	0.501}
				{His	0.165}
				{Ile	0.943}
				{Leu	0.943}
				{Lys	0.283}
				{Met	0.738}
				{Phe	1.000}
				{Pro	0.711}
				{Ser	0.359}
				{Thr	0.450}
				{Trp	0.878}
				{Tyr	0.880}
				{Val	0.825}
			}
		}
		
		hphob_breese {
			# Amino acid scale	Hydrophobicity (free energy of transfer to surface in kcal/mole). 
			# Author(s)	Bull H.B., Breese K. 
			# Reference	Arch. Biochem. Biophys. 161	665-670(1974). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.610}
				{Arg	0.690}
				{Asn	0.890}
				{Asp	0.610}
				{Cys	0.360}
				{Gln	0.970}
				{Glu	0.510}
				{Gly	0.810}
				{His	0.690}
				{Ile	-1.450}
				{Leu	-1.650}
				{Lys	0.460}
				{Met	-0.660}
				{Phe	-1.520}
				{Pro	-0.170}
				{Ser	0.420}
				{Thr	0.290}
				{Trp	-1.200}
				{Tyr	-1.430}
				{Val	-0.750}
			}
		}
		
		hphob_chothia {
			# Amino acid scale	Proportion of residues 95% buried (in 12 proteins). 
			# Author(s)	Chothia C. 
			# Reference	J. Mol. Biol. 105	1-14(1976). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.380}
				{Arg	0.010}
				{Asn	0.120}
				{Asp	0.150}
				{Cys	0.500}
				{Gln	0.070}
				{Glu	0.180}
				{Gly	0.360}
				{His	0.170}
				{Ile	0.600}
				{Leu	0.450}
				{Lys	0.030}
				{Met	0.400}
				{Phe	0.500}
				{Pro	0.180}
				{Ser	0.220}
				{Thr	0.230}
				{Trp	0.270}
				{Tyr	0.150}
				{Val	0.540}
			}
		}
		
		hphob_doolittle {
			# Amino acid scale	Hydropathicity. 
			# Author(s)	Kyte J., Doolittle R.F. 
			# Reference	J. Mol. Biol. 157	105-132(1982). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.800}
				{Arg	-4.500}
				{Asn	-3.500}
				{Asp	-3.500}
				{Cys	2.500}
				{Gln	-3.500}
				{Glu	-3.500}
				{Gly	-0.400}
				{His	-3.200}
				{Ile	4.500}
				{Leu	3.800}
				{Lys	-3.900}
				{Met	1.900}
				{Phe	2.800}
				{Pro	-1.600}
				{Ser	-0.800}
				{Thr	-0.700}
				{Trp	-0.900}
				{Tyr	-1.300}
				{Val	4.200}
			}
		}
		
		hphob_eisenberg {
			# Amino acid scale	Normalized consensus hydrophobicity scale. 
			# Author(s)	Eisenberg D., Schwarz E., Komarony M., Wall R. 
			# Reference	J. Mol. Biol. 179	125-142(1984). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.620}
				{Arg	-2.530}
				{Asn	-0.780}
				{Asp	-0.900}
				{Cys	0.290}
				{Gln	-0.850}
				{Glu	-0.740}
				{Gly	0.480}
				{His	-0.400}
				{Ile	1.380}
				{Leu	1.060}
				{Lys	-1.500}
				{Met	0.640}
				{Phe	1.190}
				{Pro	0.120}
				{Ser	-0.180}
				{Thr	-0.050}
				{Trp	0.810}
				{Tyr	0.260}
				{Val	1.080}
			}
		}
		
		hphob_fauchere {
			# Amino acid scale	Hydrophobicity scale (pi-r). 
			# Author(s)	Fauchere J.-L., Pliska V.E. 
			# Reference	Eur. J. Med. Chem. 18	369-375(1983). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.310}
				{Arg	-1.010}
				{Asn	-0.600}
				{Asp	-0.770}
				{Cys	1.540}
				{Gln	-0.220}
				{Glu	-0.640}
				{Gly	0.000}
				{His	0.130}
				{Ile	1.800}
				{Leu	1.700}
				{Lys	-0.990}
				{Met	1.230}
				{Phe	1.790}
				{Pro	0.720}
				{Ser	-0.040}
				{Thr	0.260}
				{Trp	2.250}
				{Tyr	0.960}
				{Val	1.220}
			}
		}
		
		hphob_guy {
			# Amino acid scale	Hydrophobicity scale based on free energy of transfer (kcal/mole). 
			# Author(s)	Guy H.R. 
			# Reference	Biophys J. 47	61-70(1985). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.100}
				{Arg	1.910}
				{Asn	0.480}
				{Asp	0.780}
				{Cys	-1.420}
				{Gln	0.950}
				{Glu	0.830}
				{Gly	0.330}
				{His	-0.500}
				{Ile	-1.130}
				{Leu	-1.180}
				{Lys	1.400}
				{Met	-1.590}
				{Phe	-2.120}
				{Pro	0.730}
				{Ser	0.520}
				{Thr	0.070}
				{Trp	-0.510}
				{Tyr	-0.210}
				{Val	-1.270}
			}
		}
		
		hphob_janin {
			# Amino acid scale	Free energy of transfer from inside to outside of a globular protein. 
			# Author(s)	Janin J. 
			# Reference	Nature 277	491-492(1979). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.300}
				{Arg	-1.400}
				{Asn	-0.500}
				{Asp	-0.600}
				{Cys	0.900}
				{Gln	-0.700}
				{Glu	-0.700}
				{Gly	0.300}
				{His	-0.100}
				{Ile	0.700}
				{Leu	0.500}
				{Lys	-1.800}
				{Met	0.400}
				{Phe	0.500}
				{Pro	-0.300}
				{Ser	-0.100}
				{Thr	-0.200}
				{Trp	0.300}
				{Tyr	-0.400}
				{Val	0.600}
			}
		}
		
		hphob_leo {
			# Amino acid scale: Hydrophobicity (delta G1/2 cal) 
			# Author(s): Abraham D.J., Leo A.J. 
			# Reference	Proteins	Structure, Function and Genetics 2	130-152(1987). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.440}
				{Arg	-2.420}
				{Asn	-1.320}
				{Asp	-0.310}
				{Cys	0.580}
				{Gln	-0.710}
				{Glu	-0.340}
				{Gly	0.000}
				{His	-0.010}
				{Ile	2.460}
				{Leu	2.460}
				{Lys	-2.450}
				{Met	1.100}
				{Phe	2.540}
				{Pro	1.290}
				{Ser	-0.840}
				{Thr	-0.410}
				{Trp	2.560}
				{Tyr	1.630}
				{Val	1.730}
			}
		}
		
		hphob_manavalan {
			# Amino acid scale	Average surrounding hydrophobicity. 
			# Author(s)	Manavalan P., Ponnuswamy P.K. 
			# Reference	Nature 275	673-674(1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	12.970}
				{Arg	11.720}
				{Asn	11.420}
				{Asp	10.850}
				{Cys	14.630}
				{Gln	11.760}
				{Glu	11.890}
				{Gly	12.430}
				{His	12.160}
				{Ile	15.670}
				{Leu	14.900}
				{Lys	11.360}
				{Met	14.390}
				{Phe	14.000}
				{Pro	11.370}
				{Ser	11.230}
				{Thr	11.690}
				{Trp	13.930}
				{Tyr	13.420}
				{Val	15.710}
			}
		}
		
		hphob_miyazawa {
			# Amino acid scale	Hydrophobicity scale (contact energy derived from 3D data). 
			# Author(s)	Miyazawa S., Jernigen R.L. 
			# Reference	Macromolecules 18	534-552(1985). 
			# Amino acid scale values
			set wholeScale {
				{Ala	5.330}
				{Arg	4.180}
				{Asn	3.710}
				{Asp	3.590}
				{Cys	7.930}
				{Gln	3.870}
				{Glu	3.650}
				{Gly	4.480}
				{His	5.100}
				{Ile	8.830}
				{Leu	8.470}
				{Lys	2.950}
				{Met	8.950}
				{Phe	9.030}
				{Pro	3.870}
				{Ser	4.090}
				{Thr	4.490}
				{Trp	7.660}
				{Tyr	5.890}
				{Val	7.630}
			}
		}
		
		hphob_mobility {
			# Amino acid scale	Mobilities of amino acids on chromatography paper (RF). 
			# Author(s)	Aboderin A.A. 
			# Reference	Int. J. Biochem. 2	537-544(1971). 
			# Amino acid scale values
			set wholeScale {
				{Ala	5.100}
				{Arg	2.000}
				{Asn	0.600}
				{Asp	0.700}
				{Cys	0.000}
				{Gln	1.400}
				{Glu	1.800}
				{Gly	4.100}
				{His	1.600}
				{Ile	9.300}
				{Leu	10.000}
				{Lys	1.300}
				{Met	8.700}
				{Phe	9.600}
				{Pro	4.900}
				{Ser	3.100}
				{Thr	3.500}
				{Trp	9.200}
				{Tyr	8.000}
				{Val	8.500}
			}
		}
		
		hphob_parker {
			# Amino acid scale	Hydrophilicity scale derived from HPLC peptide retention times. 
			# Author(s)	Parker J.M.R., Guo D., Hodges R.S. 
			# Reference	Biochemistry 25	5425-5431(1986). 
			# Amino acid scale values
			set wholeScale {
				{Ala	2.100}
				{Arg	4.200}
				{Asn	7.000}
				{Asp	10.000}
				{Cys	1.400}
				{Gln	6.000}
				{Glu	7.800}
				{Gly	5.700}
				{His	2.100}
				{Ile	-8.000}
				{Leu	-9.200}
				{Lys	5.700}
				{Met	-4.200}
				{Phe	-9.200}
				{Pro	2.100}
				{Ser	6.500}
				{Thr	5.200}
				{Trp	-10.000}
				{Tyr	-1.900}
				{Val	-3.700}
			}
		}
		
		hphob_ph3.4 {
			# Amino acid scale	Hydrophobicity indices at ph 3.4 determined by HPLC. 
			# Author(s)	Cowan R., Whittaker R.G. 
			# Reference	Peptide Research 3	75-80(1990). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.420}
				{Arg	-1.560}
				{Asn	-1.030}
				{Asp	-0.510}
				{Cys	0.840}
				{Gln	-0.960}
				{Glu	-0.370}
				{Gly	0.000}
				{His	-2.280}
				{Ile	1.810}
				{Leu	1.800}
				{Lys	-2.030}
				{Met	1.180}
				{Phe	1.740}
				{Pro	0.860}
				{Ser	-0.640}
				{Thr	-0.260}
				{Trp	1.460}
				{Tyr	0.510}
				{Val	1.340}
			}
		}
		
		hphob_ph7.5 {
			# Amino acid scale	Hydrophobicity indices at ph 7.5 determined by HPLC. 
			# Author(s)	Cowan R., Whittaker R.G. 
			# Reference	Peptide Research 3	75-80(1990). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.350}
				{Arg	-1.500}
				{Asn	-0.990}
				{Asp	-2.150}
				{Cys	0.760}
				{Gln	-0.930}
				{Glu	-1.950}
				{Gly	0.000}
				{His	-0.650}
				{Ile	1.830}
				{Leu	1.800}
				{Lys	-1.540}
				{Met	1.100}
				{Phe	1.690}
				{Pro	0.840}
				{Ser	-0.630}
				{Thr	-0.270}
				{Trp	1.350}
				{Tyr	0.390}
				{Val	1.320}
			}
		}
		
		hphob_rose {
			# Amino acid scale	Mean fractional area loss (f) [average area buried/standard state area]. 
			# Author(s)	Rose G.D., Geselowitz A.R., Lesser G.J., Lee R.H., Zehfus M.H. 
			# Reference	Science 229	834-838(1985). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.740}
				{Arg	0.640}
				{Asn	0.630}
				{Asp	0.620}
				{Cys	0.910}
				{Gln	0.620}
				{Glu	0.620}
				{Gly	0.720}
				{His	0.780}
				{Ile	0.880}
				{Leu	0.850}
				{Lys	0.520}
				{Met	0.850}
				{Phe	0.880}
				{Pro	0.640}
				{Ser	0.660}
				{Thr	0.700}
				{Trp	0.850}
				{Tyr	0.760}
				{Val	0.860}
			}
		}
		
		hphob_roseman {
			# Amino acid scale	Hydrophobicity scale (pi-r). 
			# Author(s)	Roseman M.A. 
			# Reference	J. Mol. Biol. 200	513-522(1988). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.390}
				{Arg	-3.950}
				{Asn	-1.910}
				{Asp	-3.810}
				{Cys	0.250}
				{Gln	-1.300}
				{Glu	-2.910}
				{Gly	0.000}
				{His	-0.640}
				{Ile	1.820}
				{Leu	1.820}
				{Lys	-2.770}
				{Met	0.960}
				{Phe	2.270}
				{Pro	0.990}
				{Ser	-1.240}
				{Thr	-1.000}
				{Trp	2.130}
				{Tyr	1.470}
				{Val	1.300}
			}
		}
		
		hphob_sweet {
			# Amino acid scale	Optimized matching hydrophobicity (OMH). 
			# Author(s)	Sweet R.M., Eisenberg D. 
			# Reference	J. Mol. Biol. 171	479-488(1983). 
			# Amino acid scale values
			set wholeScale {
				{Ala	-0.400}
				{Arg	-0.590}
				{Asn	-0.920}
				{Asp	-1.310}
				{Cys	0.170}
				{Gln	-0.910}
				{Glu	-1.220}
				{Gly	-0.670}
				{His	-0.640}
				{Ile	1.250}
				{Leu	1.220}
				{Lys	-0.670}
				{Met	1.020}
				{Phe	1.920}
				{Pro	-0.490}
				{Ser	-0.550}
				{Thr	-0.280}
				{Trp	0.500}
				{Tyr	1.670}
				{Val	0.910}
			}
		}
		
		hphob_welling {
			# Amino acid scale	Antigenicity value X 10. 
			# Author(s)	Welling G.W., Weijer W.J., Van der Zee R., Welling-Wester S. 
			# Reference	FEBS Lett. 188	215-218(1985). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.150}
				{Arg	0.580}
				{Asn	-0.770}
				{Asp	0.650}
				{Cys	-1.200}
				{Gln	-0.110}
				{Glu	-0.710}
				{Gly	-1.840}
				{His	3.120}
				{Ile	-2.920}
				{Leu	0.750}
				{Lys	2.060}
				{Met	-3.850}
				{Phe	-1.410}
				{Pro	-0.530}
				{Ser	-0.260}
				{Thr	-0.450}
				{Trp	-1.140}
				{Tyr	0.130}
				{Val	-0.130}
			}
		}
		
		hphob_wilson {
			# Amino acid scale	Hydrophobic constants derived from HPLC peptide retention times. 
			# Author(s)	Wilson K.J., Honegger A., Stotzel R.P., Hughes G.J. 
			# Reference	Biochem. J. 199	31-41(1981). 
			# Amino acid scale values
			set wholeScale {
				{Ala	-0.300}
				{Arg	-1.100}
				{Asn	-0.200}
				{Asp	-1.400}
				{Cys	6.300}
				{Gln	-0.200}
				{Glu	0.000}
				{Gly	1.200}
				{His	-1.300}
				{Ile	4.300}
				{Leu	6.600}
				{Lys	-3.600}
				{Met	2.500}
				{Phe	7.500}
				{Pro	2.200}
				{Ser	-0.600}
				{Thr	-2.200}
				{Trp	7.900}
				{Tyr	7.100}
				{Val	5.900}
			}
		}
		
		hphob_wolfenden {
			# Amino acid scale	Hydration potential (kcal/mole) at 25øC. 
			# Author(s)	Wolfenden R.V., Andersson L., Cullis P.M., Southgate C.C.F. 
			# Reference	Biochemistry 20	849-855(1981). 
			# Amino acid scale values
			set wholeScale {
				{Ala	1.940}
				{Arg	-19.920}
				{Asn	-9.680}
				{Asp	-10.950}
				{Cys	-1.240}
				{Gln	-9.380}
				{Glu	-10.200}
				{Gly	2.390}
				{His	-10.270}
				{Ile	2.150}
				{Leu	2.280}
				{Lys	-9.520}
				{Met	-1.480}
				{Phe	-0.760}
				{Pro	0.000}
				{Ser	-5.060}
				{Thr	-4.880}
				{Trp	-5.880}
				{Tyr	-6.110}
				{Val	1.990}
			}
		}
		
		hphob_woods {
			# Amino acid scale	Hydrophilicity. 
			# Author(s)	Hopp T.P., Woods K.R. 
			# Reference	Proc. Natl. Acad. Sci. U.S.A. 78	3824-3828(1981). 
			# Amino acid scale values
			set wholeScale {
				{Ala	-0.500}
				{Arg	3.000}
				{Asn	0.200}
				{Asp	3.000}
				{Cys	-1.000}
				{Gln	0.200}
				{Glu	3.000}
				{Gly	0.000}
				{His	-0.500}
				{Ile	-1.800}
				{Leu	-1.800}
				{Lys	3.000}
				{Met	-1.300}
				{Phe	-2.500}
				{Pro	0.000}
				{Ser	0.300}
				{Thr	-0.400}
				{Trp	-3.400}
				{Tyr	-2.300}
				{Val	-1.500}
			}
		}
		
		hplc2.1 {
			# Amino acid scale	Retention coefficient in HPLC, pH 2.1. 
			# Author(s)	Meek J.L. 
			# Reference	Proc. Natl. Acad. Sci. USA 77	1632-1636(1980). 
			# Amino acid scale values
			set wholeScale {
				{Ala	-0.100}
				{Arg	-4.500}
				{Asn	-1.600}
				{Asp	-2.800}
				{Cys	-2.200}
				{Gln	-2.500}
				{Glu	-7.500}
				{Gly	-0.500}
				{His	0.800}
				{Ile	11.800}
				{Leu	10.000}
				{Lys	-3.200}
				{Met	7.100}
				{Phe	13.900}
				{Pro	8.000}
				{Ser	-3.700}
				{Thr	1.500}
				{Trp	18.100}
				{Tyr	8.200}
				{Val	3.300}
			}
		}
		
		hplc7.4 {
			# Amino acid scale	Retention coefficient in HPLC, pH 7.4. 
			# Author(s)	Meek J.L. 
			# Reference	Proc. Natl. Acad. Sci. USA 77	1632-1636(1980). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.500}
				{Arg	0.800}
				{Asn	0.800}
				{Asp	-8.200}
				{Cys	-6.800}
				{Gln	-4.800}
				{Glu	-16.900}
				{Gly	0.000}
				{His	-3.500}
				{Ile	13.900}
				{Leu	8.800}
				{Lys	0.100}
				{Met	4.800}
				{Phe	13.200}
				{Pro	6.100}
				{Ser	1.200}
				{Thr	2.700}
				{Trp	14.900}
				{Tyr	6.100}
				{Val	2.700}
			}
		}
		
		hplchfba {
			# Amino acid scale	Retention coefficient in HFBA. 
			# Author(s)	Browne C.A., Bennett H.P.J., Solomon S. 
			# Reference	Anal. Biochem. 124	201-208(1982). 
			# Amino acid scale values
			set wholeScale {
				{Ala	3.900}
				{Arg	3.200}
				{Asn	-2.800}
				{Asp	-2.800}
				{Cys	-14.300}
				{Gln	1.800}
				{Glu	-7.500}
				{Gly	-2.300}
				{His	2.000}
				{Ile	11.000}
				{Leu	15.000}
				{Lys	-2.500}
				{Met	4.100}
				{Phe	14.700}
				{Pro	5.600}
				{Ser	-3.500}
				{Thr	1.100}
				{Trp	17.800}
				{Tyr	3.800}
				{Val	2.100}
			}
		}
		
		hplctfa {
			# Amino acid scale	Retention coefficient in TFA. 
			# Author(s)	Browne C.A., Bennett H.P.J., Solomon S. 
			# Reference	Anal. Biochem. 124	201-208(1982). 
			# Amino acid scale values
			set wholeScale {
				{Ala	7.300}
				{Arg	-3.600}
				{Asn	-5.700}
				{Asp	-2.900}
				{Cys	-9.200}
				{Gln	-0.300}
				{Glu	-7.100}
				{Gly	-1.200}
				{His	-2.100}
				{Ile	6.600}
				{Leu	20.000}
				{Lys	-3.700}
				{Met	5.600}
				{Phe	19.200}
				{Pro	5.100}
				{Ser	-4.100}
				{Thr	0.800}
				{Trp	16.300}
				{Tyr	5.900}
				{Val	3.500}
			}
		}
		
		molecularweight {
			# Amino acid scale	Molecular weight of each amino acid. 
			# Author(s)	- 
			# Reference	Most textbooks. 
			# Amino acid scale values
			set wholeScale {
				{Ala	89.000}
				{Arg	174.000}
				{Asn	132.000}
				{Asp	133.000}
				{Cys	121.000}
				{Gln	146.000}
				{Glu	147.000}
				{Gly	75.000}
				{His	155.000}
				{Ile	131.000}
				{Leu	131.000}
				{Lys	146.000}
				{Met	149.000}
				{Phe	165.000}
				{Pro	115.000}
				{Ser	105.000}
				{Thr	119.000}
				{Trp	204.000}
				{Tyr	181.000}
				{Val	117.000}
			}
		}
		
		numbercodons {
			# Amino acid scale	Number of codon(s) coding for each amino acid in universal genetic code. 
			# Author(s)	- 
			# Reference	Most textbooks. 
			# Amino acid scale values
			set wholeScale {
				{Ala	4.000}
				{Arg	6.000}
				{Asn	2.000}
				{Asp	2.000}
				{Cys	2.000}
				{Gln	2.000}
				{Glu	2.000}
				{Gly	4.000}
				{His	2.000}
				{Ile	3.000}
				{Leu	6.000}
				{Lys	2.000}
				{Met	1.000}
				{Phe	2.000}
				{Pro	4.000}
				{Ser	6.000}
				{Thr	4.000}
				{Trp	1.000}
				{Tyr	2.000}
				{Val	4.000}
			}
		}
		
		parallelbetastrand {
			# Amino acid scale: Conformational preference for parallel beta strand. 
			# Author(s): Lifson S., Sander C. 
			# Reference: Nature 282:109-111(1979). 
			# Amino acid scale values:
			set wholeScale {
				{Ala	1.000}
				{Arg	0.680}
				{Asn	0.540}
				{Asp	0.500}
				{Cys	0.910}
				{Gln	0.280}
				{Glu	0.590}
				{Gly	0.790}
				{His	0.380}
				{Ile	2.600}
				{Leu	1.420}
				{Lys	0.590}
				{Met	1.490}
				{Phe	1.300}
				{Pro	0.350}
				{Ser	0.700}
				{Thr	0.590}
				{Trp	0.890}
				{Tyr	1.080}
				{Val	2.630}
			}
		}
		
		polarity_grantham {
			# Amino acid scale	Polarity (p). 
			# Author(s)	Grantham R. 
			# Reference	Science 185	862-864(1974). 
			# Amino acid scale values
			set wholeScale {
				{Ala	8.100}
				{Arg	10.500}
				{Asn	11.600}
				{Asp	13.000}
				{Cys	5.500}
				{Gln	10.500}
				{Glu	12.300}
				{Gly	9.000}
				{His	10.400}
				{Ile	5.200}
				{Leu	4.900}
				{Lys	11.300}
				{Met	5.700}
				{Phe	5.200}
				{Pro	8.000}
				{Ser	9.200}
				{Thr	8.600}
				{Trp	5.400}
				{Tyr	6.200}
				{Val	5.900}
			}
		}
		
		polarity_zimmerman {
			# Amino acid scale	Polarity. 
			# Author(s)	Zimmerman J.M., Eliezer N., Simha R. 
			# Reference	J. Theor. Biol. 21	170-201(1968). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.000}
				{Arg	52.000}
				{Asn	3.380}
				{Asp	49.700}
				{Cys	1.480}
				{Gln	3.530}
				{Glu	49.900}
				{Gly	0.000}
				{His	51.600}
				{Ile	0.130}
				{Leu	0.130}
				{Lys	49.500}
				{Met	1.430}
				{Phe	0.350}
				{Pro	1.580}
				{Ser	1.670}
				{Thr	1.660}
				{Trp	2.100}
				{Tyr	1.610}
				{Val	0.130}
			}
		}
		
		ratioside {
			# Amino acid scale	Atomic weight ratio of hetero elements in end group to C in side chain. 
			# Author(s)	Grantham R. 
			# Reference	Science 185	862-864(1974). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.000}
				{Arg	0.650}
				{Asn	1.330}
				{Asp	1.380}
				{Cys	2.750}
				{Gln	0.890}
				{Glu	0.920}
				{Gly	0.740}
				{His	0.580}
				{Ile	0.000}
				{Leu	0.000}
				{Lys	0.330}
				{Met	0.000}
				{Phe	0.000}
				{Pro	0.390}
				{Ser	1.420}
				{Thr	0.710}
				{Trp	0.130}
				{Tyr	0.200}
				{Val	0.000}
			}
		}
		
		recognitionfactors {
			# Amino acid scale	Recognition factors. 
			# Author(s)	Fraga S. 
			# Reference	Can. J. Chem. 60	2606-2610(1982). 
			# Amino acid scale values
			set wholeScale {
				{Ala	78.000}
				{Arg	95.000}
				{Asn	94.000}
				{Asp	81.000}
				{Cys	89.000}
				{Gln	87.000}
				{Glu	78.000}
				{Gly	84.000}
				{His	84.000}
				{Ile	88.000}
				{Leu	85.000}
				{Lys	87.000}
				{Met	80.000}
				{Phe	81.000}
				{Pro	91.000}
				{Ser	107.000}
				{Thr	93.000}
				{Trp	104.000}
				{Tyr	84.000}
				{Val	89.000}
			}
		}
		
		refractivity {
			# Amino acid scale	Refractivity. 
			# Author(s)	Jones. D.D. 
			# Reference	J. Theor. Biol. 50	167-184(1975). 
			# Amino acid scale values
			set wholeScale {
				{Ala	4.340}
				{Arg	26.660}
				{Asn	12.000}
				{Asp	13.280}
				{Cys	35.770}
				{Gln	17.260}
				{Glu	17.560}
				{Gly	0.000}
				{His	21.810}
				{Ile	18.780}
				{Leu	19.060}
				{Lys	21.290}
				{Met	21.640}
				{Phe	29.400}
				{Pro	10.930}
				{Ser	6.350}
				{Thr	11.010}
				{Trp	42.530}
				{Tyr	31.530}
				{Val	13.920}
			}
		}
		
		relativemutability {
			# Amino acid scale	Relative mutability of amino acids (Ala=100). 
			# Author(s)	Dayhoff M.O., Schwartz R.M., Orcutt B.C. 
			# Reference	In "Atlas of Protein Sequence and Structure", Vol.5, Suppl.3 (1978). 
			# Amino acid scale values
			set wholeScale {
				{Ala	100.000}
				{Arg	65.000}
				{Asn	134.000}
				{Asp	106.000}
				{Cys	20.000}
				{Gln	93.000}
				{Glu	102.000}
				{Gly	49.000}
				{His	66.000}
				{Ile	96.000}
				{Leu	40.000}
				{Lys	56.000}
				{Met	94.000}
				{Phe	41.000}
				{Pro	56.000}
				{Ser	120.000}
				{Thr	97.000}
				{Trp	18.000}
				{Tyr	41.000}
				{Val	74.000}
			}
		}
		
		totalbetastrand {
			# Amino acid scale	Conformational preference for total beta strand (antiparallel+parallel). 
			# Author(s)	Lifson S., Sander C. 
			# Reference	Nature 282	109-111(1979). 
			# Amino acid scale values
			set wholeScale {
				{Ala	0.920}
				{Arg	0.930}
				{Asn	0.600}
				{Asp	0.480}
				{Cys	1.160}
				{Gln	0.950}
				{Glu	0.610}
				{Gly	0.610}
				{His	0.930}
				{Ile	1.810}
				{Leu	1.300}
				{Lys	0.700}
				{Met	1.190}
				{Phe	1.250}
				{Pro	0.400}
				{Ser	0.820}
				{Thr	1.120}
				{Trp	1.540}
				{Tyr	1.530}
				{Val	1.810}
			}
		}
		
		hphob_privalov_dcp {
			# Amino acid scale	deltaCp hydration, J/(K*mol*A^2), 25 oC
			# Author(s)	Privalov, P. L. & Khechinashvili, N. N. 
			# Reference	 J. Mol. Biol. (1974) 86, 665-684.
			# Amino acid scale values
			set wholeScale {
				{Ala	2.14}
				{Arg	-0.2}
				{Asn	-1.01}
				{Asp	-1.4}
				{Cys	2.01}
				{Gln	-0.22}
				{Glu	-0.55}
				{Gly	2.14}
				{His	-2.43}
				{Ile	2.14}
				{Leu	2.14}
				{Lys	-1.53}
				{Met	-3.83}
				{Phe	1.55}
				{Pro	1.55}
				{Ser	-1.4}
				{Thr	-1.29}
				{Trp	0.96}
				{Tyr	-1.48}
				{Val	2.14}
			}
		}
		
		hphob_privalov_dh {
			# Amino acid scale	deltaH hydration, J/(mol*A^2), 25 oC
			# Author(s)	Privalov, P. L. & Khechinashvili, N. N. 
			# Reference	 J. Mol. Biol. (1974) 86, 665-684.
			# Amino acid scale values
			set wholeScale {
				{Ala	-122}
				{Arg	-827}
				{Asn	-894}
				{Asp	-715}
				{Cys	-271}
				{Gln	-703}
				{Glu	-562}
				{Gly	-122}
				{His	-1128}
				{Ile	-122}
				{Leu	-122}
				{Lys	-714}
				{Met	-473}
				{Phe	-148}
				{Pro	-148}
				{Ser	-1045}
				{Thr	-1287}
				{Trp	-1161}
				{Tyr	-854}
				{Val	-122}
			}
		}
		
		hphob_privalov_ds {
			# Amino acid scale	deltaS hydration, J/(K*mol*A^2), 25 oC
			# Author(s)	Privalov, P. L. & Khechinashvili, N. N. 
			# Reference	 J. Mol. Biol. (1974) 86, 665-684.
			# Amino acid scale values
			set wholeScale {
				{Ala	-578}
				{Arg	-478}
				{Asn	-654}
				{Asp	-469}
				{Cys	-402}
				{Gln	-591}
				{Glu	-436}
				{Gly	-578}
				{His	-693}
				{Ile	-578}
				{Leu	-578}
				{Lys	-482}
				{Met	-412}
				{Phe	-319}
				{Pro	-319}
				{Ser	-983}
				{Thr	-1053}
				{Trp	-693}
				{Tyr	-415}
				{Val	-578}
			}
		}
		
		hphob_privalov_dg {
			# Amino acid scale	deltaG hydration, J/(mol*A^2), 25 oC
			# Author(s)	Privalov, P. L. & Khechinashvili, N. N. 
			# Reference	 J. Mol. Biol. (1974) 86, 665-684.
			# Amino acid scale values
			set wholeScale {
				{Ala	50}
				{Arg	-685}
				{Asn	-699}
				{Asp	-575}
				{Cys	-151}
				{Gln	-527}
				{Glu	-432}
				{Gly	50}
				{His	-922}
				{Ile	50}
				{Leu	50}
				{Lys	-570}
				{Met	-350}
				{Phe	-53}
				{Pro	-53}
				{Ser	-752}
				{Thr	-972}
				{Trp	-954}
				{Tyr	-730}
				{Val	50}
			}
		}
		
		default {
			puts "Unrecognized scale   '$scale'"
		}
		
	}
	
	foreach aminoAcid $wholeScale {
		[atomselect top "resname [string toupper [lindex $aminoAcid 0]]"] set beta [lindex $aminoAcid 1]
	}
# 	#Apply preselected graphical representation
# 	mol representation VDW 1.000000 8.000000
# 	mol color Beta
# 	mol selection {protein}
# 	mol material Opaque
# 	mol addrep top
	display update
	
	switch $opt {
		none {
		}
		
		scale {
			puts "Amino acid scale '$scale'"
			puts "Amino acid scale values:"
			foreach aminoAcid $wholeScale {
				puts $aminoAcid
			}
		}
		
		default {
			puts "Unrecognized option   '$opt'"
		}
	}
}


# Block for creating mutant structures in VMD+PSFGEN
package require psfgen 1.2
package provide mutant 1.0

proc mutantUsage { } {
# 	puts "Usage: mutant L109S V23D LEU19THR..."
	puts "Usage:	mutant <resnum> <mutant_restype>"
	puts " E.g.:	mutant 109 THR"
	error ""
}

proc mutant {args} {
	set topologyFile {c:/Program Files/University of Illinois/VMD/top_all27_prot_lipid_oct_cer_k.inp}
	# Print usage information if no arguments are given
	if { [llength $args]==0 } {
		mutantUsage
		return
	}
	
	# Read the mutations
	# set resIni {}
	if {[llength [lindex $args 0]]>1} {
		set args [lindex $args 0]
	}
	set resNum {}
	set resMut {}
	set mutantName [join $args ""]
	if {[llength $mutantName]>32} {set mutantName "[lrange $mutantName 0 31]..."}
	set mutantTempPrefix "[molinfo top get name]_mutant-[set mutantName]"
	for {set mutation 0} {$mutation < [llength $args]} {incr mutation 2} {
		lappend resNum [lindex $args $mutation]
		set resMutName [string toupper [lindex $args [expr $mutation + 1]]]
		case $resMutName {
			"A" {set resMutName ALA}
			"R" {set resMutName ARG}
			"N" {set resMutName ASN}
			"D" {set resMutName ASP}
			"C" {set resMutName CYS}
			"Q" {set resMutName GLN}
			"E" {set resMutName GLU}
			"G" {set resMutName GLY}
			"H" {set resMutName HIS}
			"I" {set resMutName ILE}
			"L" {set resMutName LEU}
			"K" {set resMutName LYS}
			"M" {set resMutName MET}
			"F" {set resMutName PHE}
			"P" {set resMutName PRO}
			"S" {set resMutName SER}
			"T" {set resMutName THR}
			"W" {set resMutName TRP}
			"Y" {set resMutName TYR}
			"V" {set resMutName VAL}
			"B" {set resMutName ASN}
			"Z" {set resMutName GLN}
		}
		lappend resMut $resMutName
		puts "Mutation [expr $mutation + 1]: [lindex $args $mutation] $resMutName"
	}
		
	# Autodetect protein fragments
	set prot [atomselect top protein]
	if {[llength [lsort -unique [$prot get fragment]]]==[llength [lsort -unique [$prot get pfrag]]]} {;	# successful detection of protein fragments
		set fragmentNumbers [lsort -unique -integer [$prot get fragment]]
		# Record fragments into separate pdb files, with segname set top fragment name
		set fragmentType fragment
		foreach fragmentNumber $fragmentNumbers {
			set fragmentSelection [atomselect top "fragment $fragmentNumber"]
			# $fragmentSelection set segname $fragmentNumber
			$fragmentSelection writepdb $mutantTempPrefix$fragmentNumber.pdb
		}
	} else {;	# successful detection of protein fragments
		set fragmentNumbers [lsort -unique -integer [$prot get pfrag]]
		# Record fragments into separate pdb files, with segname set top fragment name
		set fragmentType pfrag
		foreach fragmentNumber $fragmentNumbers {
			set fragmentSelection [atomselect top "pfrag [expr {[llength $fragmentNumbers] - $fragmentNumber - 1}]"];	# Such a numeration because VMD inverses ordering of protein fragments comparing to fragments
			# $fragmentSelection set segname $fragmentNumber
			$fragmentSelection writepdb $mutantTempPrefix$fragmentNumber.pdb
		}
	}
		
	# Build new mutant from fragments
	resetpsf
	topology $topologyFile
	
	# Fix Bob's broken atom and residues names
	alias residue HIS HSD
	alias atom SER H HN
	alias atom ILE H HN
	alias atom LYS H HN
	alias atom GLU H HN
	alias atom PHE H HN
	alias atom ARG H HN
	alias atom ALA H HN
	alias atom MET H HN
	alias atom ASN H HN
	alias atom ASP H HN
	alias atom GLN H HN
	alias atom GLY H HN
	alias atom HIS H HN
	alias atom LEU H HN
	alias atom THR H HN
	alias atom TYR H HN
	alias atom VAL H HN
	alias atom SER HG HG1
	alias atom ILE CD1 CD
	
	# Define residues in segment, using residues found in PDB file
	foreach fragmentNumber $fragmentNumbers {
		segment $fragmentNumber {
			first NONE
			last NONE
			pdb $mutantTempPrefix$fragmentNumber.pdb
			foreach oneResNum $resNum oneResMut $resMut {
				if {[[atomselect top "$fragmentType $fragmentNumber and resid $resNum"] num]>0} {
					puts "Mutating $oneResNum to $oneResMut in segment $fragmentNumber"
					mutate $oneResNum $oneResMut
# 					catch {mutate $oneResNum $oneResMut}
				} else {
					puts "No residues to mutate in segment $fragmentNumber"
				}
			}
		}
	}
	
	# Get coordinates from PDB file for segments Ch1-Ch7.
	foreach fragmentNumber $fragmentNumbers {
		coordpdb $mutantTempPrefix$fragmentNumber.pdb $fragmentNumber
		catch {file delete $mutantTempPrefix$fragmentNumber.pdb}
	}
	
	# Add coordinates for new atoms
	guesscoord
	
	# Write out both psf (structure) and pdb (coordinate) file
	writepsf $mutantTempPrefix.psf
	writepdb $mutantTempPrefix.pdb
	
	foreach fragmentNumber $fragmentNumbers {
		catch {file delete $mutantTempPrefix$fragmentNumber.pdb}
	}
	
	# Load the mutant into VMD
	mol load psf $mutantTempPrefix.psf pdb $mutantTempPrefix.pdb
}

proc t {} {
	#procedure sets current working folder to C:/Temp
	cd C:/Temp
	pwd
}

proc c {} {
	#Preocedure sets current working folder to the path to the last loaded file of the top molecule
	cd [file dirname [lindex [lindex [molinfo top get filename] 0] end]]
	pwd
}

# morph_AGA - set of procedures based on the "morph 1.0" by Andrew Dalke (dalke@ks.uiuc.edu), and modified to handle the trajectory with any number of frames
# ---------

# DESCRIPTION:
# This procedure generates a linear interpolation between all
# animation frames.  The interpolations are stored as additional
# frames that can be played back via the 'Animate' menu.  This
# gives the impression of a "morphing" between the two starting
# frames.  


# PROCEDURES:
# morph -  takes three parameters, the molecule id to morph,
# the number of frames to include in the interpolation, and the
# procedure to use for generating the location of the interpolations
# (by default, morph_linear)

#lin - interpolation of frames is linear, with the distance
# between successive frames being of equal lengths

# cycle - interpolation of frames is still linear, but
# more frames are generated near the beginning and ending
# positions of the morph, so that the morph appears to
# speed up and slow down.

# sin2 - interpolation of frames is still linear, but
# more frames are generated near the beginning and ending
# positions of the morph, so that the morph appears to
# speed up and slow down.

# EXAMPLE_USAGE:
# morph 10    - generates 10 frame linear interpolation between all the
#   animation frames that are presently loaded
# morph 100 cycle - generates 100 frame interpolation
#   between all the animation frames that are presently
#   loaded, using a generation scheme which produces
#   more frames near the beginning and ending than
#   near the middle (i.e. speeds up and slows down)

proc linear {t N} {
  return [expr {double($t) / double($N)}]
}

proc cycle {t N} {
  global M_PI
  return [expr {(1.0 - cos( $M_PI * double($t) / ($N + 1.0)))/2.0}]
}
proc sin2 {t N} {
  global M_PI
  return [expr {sqrt(sin( $M_PI * double($t) / double($N) / 2.0))}]
}



proc morph { N {morph_type linear}} {
	set molid top
    # make sure there are only two animation frames
    if {[molinfo $molid get numframes] < 2} {
	error "Molecule $molid must have at least 2 animation frames"
    }
    # workaround for the 'animate dup' bug; this will translate
    # 'top' to a number, if needed
    set molid [molinfo $molid get id]
    
    # Detect if the number of frames increase contains start and end positions
    set lastFrame 0
    set initialTotalFrames [expr {[molinfo $molid get numframes]-1}]
    set firstFrame 0
    if {[regexp : $N]} {; # Start and end positions are specified
	    if {[scan $N "%i:%i:%i" firstFrame N lastFrame] != 3} {
		   error "not a valid frames string"
		}
    }
    if {($lastFrame >= [molinfo $molid get numframes])||($lastFrame <= 0)} {;# Autodetect the last frame
	    set lastFrame [expr {[molinfo $molid get numframes]-1}]
    }

    set N [expr $N + 1]
    # Do some error checking on N
    if {$N != int($N)} {
	  error "Need an integer number for the number of frames"
    }
    if {$N <= 2} {
	  error "The number of frames must be greater than 2"
    }
	
    set sel1 [atomselect $molid "all" frame 0]
    set sel2 [atomselect $molid "all" frame 1]
    
    # Make all the new frames (copied from the last frame)
    set newFrames [expr {($N-2)*($lastFrame-$firstFrame)}]
    set totalMorphedFrames [expr {($N-1)*($lastFrame-$firstFrame)+1}]
    set newLastMorphedFrame [expr {$firstFrame+$totalMorphedFrames-1}]
    for {set i 0} {$i < $newFrames} {incr i} {
	  animate dup frame $initialTotalFrames $molid
    }
    
    set step $newFrames
    for {set fr $initialTotalFrames} {$fr > $lastFrame} {incr fr -1} {;	# cycle through the last unmorphed cells frames in reverse direction to copy they coordinates to the end
	    $sel1 frame $fr
	    $sel2 frame [expr {$fr+$step}]
	    $sel2 set x [$sel1 get x]
	    $sel2 set y [$sel1 get y]
	    $sel2 set z [$sel1 get z]
	}
    set step [expr $N-1]
    for {set fr $lastFrame} {$fr > $firstFrame} {incr fr -1} {;	# cycle through the frames in reverse direction to assign key coordinates for morphing frames
	    $sel1 frame $fr
	    $sel2 frame [expr {$firstFrame+$fr*$step}]
	    $sel2 set x [$sel1 get x]
	    $sel2 set y [$sel1 get y]
	    $sel2 set z [$sel1 get z]
	}

    for {set fr $firstFrame} {$fr < $newLastMorphedFrame} {incr fr $step} {;	# cycle through the frames 
	    # Get the coordinates of the first and last frames for this piece
	    $sel1 frame $fr
	    $sel2 frame [expr {$fr+$step}]
	    set x1 [$sel1 get x]
	    set y1 [$sel1 get y]
	    set z1 [$sel1 get z]
	    set x2 [$sel2 get x]
	    set y2 [$sel2 get y]
	    set z2 [$sel2 get z]
	
	
	    # Do the linear interpolation in steps of 1/N so
	    # f(0) = 0.0 and f(N-1) = 1.0
	    for {set t 1} {$t < $N-1} {incr t} {
		  # Here's the call to the user-defined morph function
		  set f [$morph_type $t [expr {$N-1}]]
		  # calculate the linear interpolation for each coordinate
		  # go to the given frame and set the coordinates
		  $sel1 frame [expr {$t+$fr}]
	      $sel1 set x [vecadd [vecscale [expr {1.0 - $f}] $x1] [vecscale $f $x2]]
	      $sel1 set y [vecadd [vecscale [expr {1.0 - $f}] $y1] [vecscale $f $y2]]
	      $sel1 set z [vecadd [vecscale [expr {1.0 - $f}] $z1] [vecscale $f $z2]]
	   } 
   	};	# cycle through the frames in reverse direction (to preserve frames numbering)

}



# Script to set the cell size for periodic boundary conditions
# Argument utodetect by the string length: 0)Specified a, b, c, alpha, beta, gamma 1) line from xsc file; 2) cell parameters from NAMD configuration; 3) xsc filename; 
proc cell {cellGeometry} {
	if {[llength $cellGeometry]==6} {;	# Specified a, b, c, alpha, beta, gamma
		set a [lindex $cellGeometry 0]
		set b [lindex $cellGeometry 1]
		set c [lindex $cellGeometry 2]
		set alpha [lindex $cellGeometry 3]
		set beta [lindex $cellGeometry 4]
		set gamma [lindex $cellGeometry 5]
	} else {
		case [llength $cellGeometry] {
			19 {
				# line from xsc file
			}
			12 {
				# cell parameters from NAMD configuration
				set cellGeometry [lreplace [lreplace $cellGeometry 8 8] 4 4]
				puts {$cellGeometry}
			}
			default {
				# xsc filename - should not have 19 or 12 parts separated by spaces
				set fileLook [open $cellGeometry r];	# Open configuration file
				for {set i 0} {$i < 3} {incr i} {
					gets $fileLook cellGeometry
				}
				close $fileLook
			}
		}
		
		set a [expr {pow((pow([lindex $cellGeometry 1],2)+pow([lindex $cellGeometry 2],2)+pow([lindex $cellGeometry 3],2)),0.5)}]
		set b [expr {pow((pow([lindex $cellGeometry 4],2)+pow([lindex $cellGeometry 5],2)+pow([lindex $cellGeometry 6],2)),0.5)}]
		set c [expr {pow((pow([lindex $cellGeometry 7],2)+pow([lindex $cellGeometry 8],2)+pow([lindex $cellGeometry 9],2)),0.5)}]
		set alpha 90
		set beta 90
		set gamma [expr {180*(1-atan([lindex $cellGeometry 5]/[lindex $cellGeometry 4])/3.1415926)}]
	}
   	molinfo top set {a b c alpha beta gamma} "$a $b $c $alpha $beta $gamma"
	puts "Info: molinfo top set 'a b c alpha beta gamma' '$a $b $c $alpha $beta $gamma'"
}

proc symm {args} {
	#Procedure to calculate symmetric structure closest to the starting structure of homooligomer, or spread conformation of one monomer onto the whole oligomer
	#Symmetrization is applied to all the atoms in selection, supposing that all the fragments containing the selection have exactly the same topology (the same number and order of atoms in the structure file)
	#repositioned atoms will be marked by positive betas, all other - by zero beta

	case [llength $args] {
		0 {
			set selection [atomselect top "protein"];	#Selection for atoms which should be symmetrized
			
			#Option to choose (1) the real monomer closest to the average (by RMSD) or (2) the real monomer fartherst from the average (by RMSD) as an average monomer and symmetrize it, or not (0) or chose the preselected monomer as a template (-1)
			set real_monomer 2
		}
		1 {
			if {[string is integer $args]} {;	# This is the number of monomer to replicate <0..(number of monomers - 1)> or the mode of replication: <-1> the real monomer closest to the average (by RMSD) or <-2> the real monomer fartherst from the average (by RMSD)
				set selection [atomselect top "protein"];	#Selection for atoms which should be symmetrized
				# Any integer from 0 and up
				set real_monomer -1;	# chose the preselected monomer as a template
				set real_monomer_number $args;	# this monomer will be used as a template for symmetrization
				
			} else {;	# The argument is a string
				#Option to choose (1) the real monomer closest to the average (by RMSD) or (2) the real monomer fartherst from the average (by RMSD) as an average monomer and symmetrize it, or not (0) or chose the preselected monomer as a template (-1)
				case $args {
					"avg" {
						set selection [atomselect top "protein"];	#Selection for atoms which should be symmetrized
						set real_monomer 0;	# the average between all the monomers
					}
					"max" {
						set selection [atomselect top "protein"];	#Selection for atoms which should be symmetrized
						set real_monomer 2;	# the real monomer fartherst from the average (by RMSD)
					}
					"min" {
						set selection [atomselect top "protein"];	#Selection for atoms which should be symmetrized
						set real_monomer 1;	# the real monomer closest to the average (by RMSD)
					}
					default {;	# The argument is the selection string
						set selection [atomselect top $args];	#Selection for atoms which should be symmetrized
						set real_monomer 2;	# the real monomer fartherst from the average (by RMSD)
					}
				};	#Option to choose (1) the real monomer....
			};	# This is the number of monomer to replicate...
		}
		2 {
			set selection [atomselect top [lindex $args 0]];	#Selection for atoms which should be symmetrized
			#Option to choose (1) the real monomer closest to the average (by RMSD) or (2) the real monomer fartherst from the average (by RMSD) as an average monomer and symmetrize it, or not (0) or chose the preselected monomer as a template (-1)
			case [lindex $args 1] {
				"avg" {
					set real_monomer 0;	# the average between all the monomers
				}
				"max" {
					set real_monomer 2;	# the real monomer fartherst from the average (by RMSD)
				}
				"min" {
					set real_monomer 1;	# the real monomer closest to the average (by RMSD)
				}
				default {;	# Any other integer number from 0 and up
					set real_monomer -1;	# chose the preselected monomer as a template
					set real_monomer_number [lindex $args 1];	# this monomer will be used as a template for symmetrization
				}
			};	#Option to choose (1) the real monomer....
		}
		default {
			error "Too many arguments"
		}
	}
	puts "[llength $args]"
	
	# Option (unimplemented) to have translational <0> or rotational <1> symmetry type
	set symmetryType 1
	
	
	
	
	
	#Autodetect Number of monomers - using the first atom of the first residue
	set firstAtoms [atomselect top "resid [lindex [$selection get resid] 0] and name [lindex [$selection get name] 0]"]
	set monomers [$firstAtoms num]
	
	#Rotation symmetry axis - x,y or z
	set rotation_axis z
	
	#Autodetect Rotation direction: 1 clockwise, -1 counterclockwise (looking in the positive direction of the axis)
	set averageDistanceClockwise 0
	set averageDistanceCounterclockwise 0
	set firstAtomVector [lindex [$firstAtoms get {x y z}] 0]
	for {set m 1} {$m < $monomers} {incr m} {;	# Add all the distances between identical atoms in the original state
		set atomVector [lindex [$firstAtoms get {x y z}] $m]
		
		set averageDistanceClockwise [expr {$averageDistanceClockwise + [vecdist $firstAtomVector [vectrans [transaxis $rotation_axis [expr {-360.0*$m/$monomers}]] $atomVector]]}]
	# 	set se
		set averageDistanceCounterclockwise [expr {$averageDistanceCounterclockwise + [vecdist $firstAtomVector [vectrans [transaxis $rotation_axis [expr {360.0*$m/$monomers}]] $atomVector]]}]
	}
	
	if {$averageDistanceClockwise < $averageDistanceCounterclockwise} {
		set rotation_direction 1; #Clockwise
	} else {
		set rotation_direction -1; #CounterClockwise
	}
	
	
	#repositioned atoms will be marked by positive betas, all other - by zero beta
	set all [atomselect top all]
	$all set beta 0
	$selection set beta 1
	
	
	#List of indexes in the selection
	set selection_indexes [$selection get index]
	
	set oligomer_atoms [$selection num]
	set monomer_atoms [expr {$oligomer_atoms / $monomers}]
	
	
	
	puts "Calculating average among the $monomers monomers"
	#Rotate all (except 1st) the monomers to overlap them and calculate the average position
	set first_index 0
	set last_index [expr {$monomer_atoms-1}]
	set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
	set average_x [$current_monomer get x]
	set average_y [$current_monomer get y]
	set average_z [$current_monomer get z]
	for {set m 1} {$m < $monomers} {incr m} {
		#Select the current monomer
		set first_index [expr {$monomer_atoms*$m}]
		set last_index [expr {$monomer_atoms*($m+1)-1}]
		set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
		#rotate monomer
		$current_monomer move [transaxis $rotation_axis [expr {-$m*$rotation_direction*360.0/$monomers}]]
		#add coordinates to average
		set average_x [vecadd $average_x [$current_monomer get x]]
		set average_y [vecadd $average_y [$current_monomer get y]]
		set average_z [vecadd $average_z [$current_monomer get z]]
	}
	
	#scale average coordinates
	set scaling_factor [expr {1.0/$monomers}]
	set average_x [vecscale $scaling_factor $average_x]
	set average_y [vecscale $scaling_factor $average_y]
	set average_z [vecscale $scaling_factor $average_z]
	
	case $real_monomer {
		"-1" {;	#Replicating the preselected monomer as an average monomer
			puts "Using the preselected monomer $real_monomer_number as a template"
			set first_index [expr {$monomer_atoms*$real_monomer_number}]
			set last_index [expr {$monomer_atoms*($real_monomer_number+1)-1}]
			set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
			set average_x [$current_monomer get x]
			set average_y [$current_monomer get y]
			set average_z [$current_monomer get z]
		}
		"0" {;	# An average coordinate will be used for every subunit. Do nothing here
		}	
		{1 2} {;	#choose the real monomer closest <1> to or farthest <2> from the average (by RMSD) as an average monomer
			puts "Comparing all the monomers with the average"
			
			#Remember coordinates of the first monomer
			set first_index 0
			set last_index [expr {$monomer_atoms-1}]
			set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
			set temp_x [$current_monomer get x]
			set temp_y [$current_monomer get y]
			set temp_z [$current_monomer get z]
			
			
			#Set averaged values to the first monomer
			$current_monomer set x $average_x
			$current_monomer set y $average_y
			$current_monomer set z $average_z
	
			#Compare all other monomers with the first/averaged monomer
	        set average_monomer $current_monomer
			set rmsd_min -1
			set rmsd_max -1
			for {set m 1} {$m < $monomers} {incr m} {
				#Select the current monomer
				set first_index [expr {$monomer_atoms*$m}]
				set last_index [expr {$monomer_atoms*($m+1)-1}]
				set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
				
				#Calculate an average rmsd for this whole monomer
		        set rmsd [measure rmsd $current_monomer $average_monomer]
		        if {$rmsd_min < 0 | $rmsd_min > $rmsd} {
			        #the first comparison or smaller rmsd
			        set rmsd_min $rmsd
			        set rmsd_min_monomer $m
		        }
		        if {$rmsd_max < 0 | $rmsd_max < $rmsd} {
			        #the first comparison or larger rmsd
			        set rmsd_max $rmsd
			        set rmsd_max_monomer $m
		        }
			}
			
			#Return coordinates of the first monomer
			$average_monomer set x $temp_x
			$average_monomer set y $temp_y
			$average_monomer set z $temp_z
			
			#Remember coordinates of the last monomer
			set first_index [expr {$monomer_atoms*($monomers-1)}]
			set last_index [expr {$monomer_atoms*($monomers)-1}]
			set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
			set temp_x [$current_monomer get x]
			set temp_y [$current_monomer get y]
			set temp_z [$current_monomer get z]
			
			#Set averaged values to the last monomer
			$current_monomer set x $average_x
			$current_monomer set y $average_y
			$current_monomer set z $average_z
			
			#Compare the first monomer with the last/averaged monomer
	        set average_monomer $current_monomer
			#Take the first monomer to compare
			set first_index 0
			set last_index [expr {$monomer_atoms-1}]
			set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
			
			#Calculate an average rmsd for this whole monomer
	        set rmsd [measure rmsd $current_monomer $average_monomer]
	        if {$rmsd_min > $rmsd} {
		        set rmsd_min $rmsd
		        set rmsd_min_monomer 0
	        }
	        if {$rmsd_max < $rmsd} {
		        set rmsd_max $rmsd
		        set rmsd_max_monomer 0
	        }

	
	        #Return coordinates of the last monomer
			$average_monomer set x $temp_x
			$average_monomer set y $temp_y
			$average_monomer set z $temp_z
			
			#Record coordinates of the monomer closest to average as the average coordinates
			if {$real_monomer==1} {
				puts "Monomer $rmsd_min_monomer is the closest to the average. Using it as a template for all the monomers."
				set first_index [expr {$monomer_atoms*$rmsd_min_monomer}]
				set last_index [expr {$monomer_atoms*($rmsd_min_monomer+1)-1}]
			} else {
				puts "Monomer $rmsd_min_monomer is the farthest from the average. Using it as a template for all the monomers."
				set first_index [expr {$monomer_atoms*$rmsd_max_monomer}]
				set last_index [expr {$monomer_atoms*($rmsd_max_monomer+1)-1}]
			}
			set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
			set average_x [$current_monomer get x]
			set average_y [$current_monomer get y]
			set average_z [$current_monomer get z]
		}
	}; #scale average
			
	#Set average positions and Rotate all (except 1st) the monomers back to initial orientations
	puts "Assigning symmetric coordinates to the monomers"
	for {set m 0} {$m < $monomers} {incr m} {
		#Select the current monomer
		set first_index [expr {$monomer_atoms*$m}]
		set last_index [expr {$monomer_atoms*($m+1)-1}]
		set current_monomer [atomselect top "index [lrange $selection_indexes $first_index $last_index]"]
		#set average coordinates
		$current_monomer set x $average_x
		$current_monomer set y $average_y
		$current_monomer set z $average_z

		#rotate monomer
	 	$current_monomer move [transaxis $rotation_axis [expr {$m*$rotation_direction*360.0/$monomers}]]
	}; #Set average positions and Rotate all
}	


# Script that loads coordinates from the filelist and adds them as new frames to the top molecule
proc a {args} {
	regsub -all {\\} $args {/} args
	if { ![llength $args] } {
		puts "a	Loads coordinates from the filelist and adds them as new frames to the top molecule
	Syntax: a {file1.coor file2.pdb file3.dcd}; a {c:/temp} {file1.dcd} 10
	Filenames can be separated by new lines. First argument can be path to files, it can be
	omitted or empty. The third argument can be step for trajectory reading or can be omitted."
	} else {
		set step 1
		if {[llength $args]==1} {
			set filelist [lindex $args 0]
		} elseif {[llength $args]==2} {
			if {[llength [lindex $args 0]]>0} {cd [lindex $args 0]}
			set filelist [lindex $args 1]
		} elseif {[llength $args]==3} {
			if {[llength [lindex $args 0]]>0} {cd [lindex $args 0]}
			set filelist [lindex $args 1]
			set step [lindex $args 2]
		}
		foreach file $filelist {;	# Load files
			if {[catch {mol addfile $file step $step waitfor all}]!=0} {
				if {[catch {mol addfile $file type namdbin waitfor all}]!=0} {
					if {[catch {mol addfile $file type pdb waitfor all}]!=0} {
						puts "File $file not recognized"
					}
				}
			}
		}
	}
}


# Script that loads coordinates from the filelist and adds them as new molecules.
proc n {args} {
	regsub -all {\\} $args {/} args
	if { ![llength $args] } {
		puts "n	Loads coordinates from the filelist and adds them as new files.
	Syntax: n {file1.coor file2.pdb file3.dcd}; n {c:/temp} {file1.dcd} 10
	Filenames can be separated by new lines. First argument can be path to files, it can be
	omitted or empty. The third argument can be step for trajectory reading or can be omitted."
	} else {
		set step 1
		if {[llength $args]==1} {
			set filelist [lindex $args 0]
		} elseif {[llength $args]==2} {
			if {[llength [lindex $args 0]]>0} {cd [lindex $args 0]}
			set filelist [lindex $args 1]
		} elseif {[llength $args]==3} {
			if {[llength [lindex $args 0]]>0} {cd [lindex $args 0]}
			set filelist [lindex $args 1]
			set step [lindex $args 2]
		}
		foreach file $filelist {;	# Load files
			if {[catch {mol new $file step $step waitfor all}]!=0} {
				if {[catch {mol new $file type namdbin waitfor all}]!=0} {
					if {[catch {mol new $file type pdb waitfor all}]!=0} {
						puts "File $file not recognized"
					}
				}
			}
		}
	}
}


#Script to set atomic VDW radii according to the values read from the predefined values, or from file with atom types and radii, or from CHARMM parameters file

proc radii {args} {
	set atom_type {}
	set atom_radius {}

	if {[llength $args]==0} {
		puts "proc	sets atomic VDW radii according to the values read from the predefined values,
	 or from file with atom types and radii, or from CHARMM parameters file.
	Syntax: radii {}  ==> Displays brief help and sets predefined CHARMM radii
        radii v  ==> restores default VMD radii
        radii {c:/path/param_charmm.inp}  ==> reads radii from CHARMM parameters file
        radii {c:/path/raddi_file.txt} r  ==> reads radii from 'type TAB radius' file"
        # CHARMM radii used by NAMD by default
        set typeRadiusList {
				C	2
				CA	1.9924
				CAL	1.367
				CC	2
				CD	2
				CE1	2.09
				CE2	2.08
				CEL1	2.09
				CEL2	2.08
				CES	2.1
				CL	2
				CLA	2.27
				CM	2.1
				CP1	2.275
				CP2	2.175
				CP3	2.175
				CPA	1.8
				CPB	1.8
				CPH1	1.8
				CPH2	1.8
				CPM	1.8
				CPT	1.8
				CS	2.2
				CT1	2.275
				CT2	2.175
				CT3	2.06
				CTL1	2.275
				CTL2	2.01
				CTL3	2.04
				CTL5	2.06
				CY	1.9924
				DUM	0
				FE	0.65
				H	0.2245
				HA	1.32
				HAL1	1.32
				HAL2	1.34
				HAL3	1.34
				HB	1.32
				HC	0.2245
				HCL	0.2245
				HE	1.48
				HE1	1.25
				HE2	1.26
				HEL1	1.25
				HEL2	1.26
				HL	0.7
				HOL	0.2245
				HP	1.3582
				HR1	0.9
				HR2	0.7
				HR3	1.468
				HS	0.45
				HT	0.2245
				LP	0.2245
				MG	1.185
				N	1.85
				NC2	1.85
				NE	1.53
				NH1	1.85
				NH2	1.85
				NH3	1.85
				NH3L	1.85
				NP	1.85
				NPH	1.85
				NR1	1.85
				NR2	1.85
				NR3	1.85
				NTL	1.85
				NY	1.85
				O	1.7
				O2L	1.7
				OB	1.7
				OBL	1.7
				OC	1.7
				OCL	1.7
				OH1	1.77
				OH2	1.7398
				OHL	1.77
				OM	1.7
				OS	1.77
				OSL	1.77
				OT	1.7682
				PL	2.15
				POT	1.76375
				S	2
				SL	2.1
				SM	1.975
				SOD	1.36375
				SS	2.2
				ZN	1.09
        }
        
        for {set n 0} {$n < [expr [llength $typeRadiusList]/2]} {incr n} {
			lappend atom_type [lindex $typeRadiusList [expr $n*2]]
			lappend atom_radius [lindex $typeRadiusList [expr $n*2+1]]
        }
        
	} elseif {[llength $args]==1} {
		case [lindex $args 0] {
			{v VMD vmd} {;	# VMD default radii
				set atom_type {C.* H.* N.* O.* S.*}
				set atom_radius {1.5 1 1.4 1.3 1.9}
			} 
			{n NAMD namd} {;	# CHARMM radii used by NAMD by default
				radii
				return
			}
			default {;	# Extracts VDW radii from the CHARMM parameters file
				set filename [lindex $args 0]
				# open the file
				set file_look [open $filename r]
				
				#read the data
				set readingStatus -1;	# Flag for radii reading status: <-1> has not reached reading point yet; <0> - started reading; <1> - finished reading
				puts "Started reading of CHARMM parameters file"
				while {[gets $file_look line] >= 0} {
					# test for the numeric content of the second column
					regsub -all {"} $line '' line
#  					if {$readingStatus>-1} {puts "$readingStatus ==> $line"}
					switch -regexp [lindex $line 0] {
						"^!" {}
						"^[*]" {}
						"^$" {}
						"cutnb" {}
						"NONBONDED" {;	# Beginning of the radii section
							set readingStatus 0
						}
						default {
							case $readingStatus {
								-1 {;	# Ignore lines before  the radii section
								}
								0 {
									if {([llength $line]>3)&&[string is double [lindex $line 1]]} {
										lappend atom_type [lindex $line 0]
										lappend atom_radius [lindex $line 3]
									} else {;	# Probably the end of the radii section
										set readingStatus 1
									}
								}
								1 {;	# Ignore lines after  the radii section
									
								}
							}
						}
					}
				}
				puts "Finished reading of CHARMM parameters file. [llength $atom_radius] radii extracted."
				
				#Close the file
				close $file_look
			}
		}
	} elseif {[llength $args]==2} {;	# Plain text File with radii - first line - column names, ignored. Other lines - 2 values - atom type and radius - separated by tabs
		set filename [lindex $args 0]
		
		# open the file
		set file_look [open $filename r]
		
		#read the data
		while {[gets $file_look line] > 0} {
			# test for the numeric content of the second column
			if {[string is double [lindex $line 1]]} {
				lappend atom_type [lindex $line 0]
				lappend atom_radius [lindex $line 1]
			}
		}
		
		#Close the file
		close $file_look
	} else {
		error "Number of input parameters is too big"
	}

	
	#Go through atom types and assign the radii. If atom type is unknown, radius is not changed
	#set all [atomselect top all]
	foreach type $atom_type radius $atom_radius {
 		puts "$type    $radius"
		set sel [atomselect top "type \"$type\""]
		$sel set radius $radius
		$sel delete
	}
	puts "Radii assignment finished !!!"
}

proc ss {{molid top}} {
	# Based on the sscache script by Andrew Dalke (dalke@ks.uiuc.edu)
	# Cache secondary structure information for a given molecule
	
	#VMD  --- start of VMD description block
	#Name:
	# SSCache
	#Synopsis:
	# Automatically stores secondary structure information for animations
	#Version:
	# 1.0
	#Uses VMD version:
	# 1.1
	#Ease of use:
	# 2
	#Procedures:
	# <li>start_sscache molid - start caching the given molecule
	# <li>stop_sscache molid - stop caching
	# <li>reset_sscache - reset the cache
	# <li>sscache - internal function used by trace
	#Description:
	# Calculates and stores the secondary structure assignment for 
	# each timestep.  This lets you see how the secondary structure
	# changes over a trajectory.
	# <p>
	# It is turned on with the command "start_sscache> followed by the
	# molecule number of the molecule whose secondary structure should be
	# saved (the default is "top", which gets converted to the correct
	# molecule index).  Whenever the frame for that molecule changes, the
	# procedure "sscache" is called.
	# <p>
	#   "sscache" is the heart of the script.  It checks if a secondary
	# structure definition for the given molecule number and frame already
	# exists in the Tcl array sscache_data(molecule,frame).  If so, it uses
	# the data to redefine the "structure" keyword values (but only for
	# the protein residues).  If not, it calls the secondary structure
	# routine to evaluate the secondary structure based on the new
	# coordinates.  The results are saved in the sscache_data array.
	# <p>
	# Once the secondary structure values are saved, the molecule can be
	# animated rather quickly and the updates can be controlled by the
	# animate form.
	# <p>
	#  To turn off the trace, use the command "stop_sscache", which
	# also takes the molecule number.  There must be one "stop_sscache"
	# for each "start_sscache".  The command "clear_sscache" resets
	# the saved secondary structure data for all the molecules and all the
	# frames.
	#Files: 
	# <a href="sscache.vmd">sscache.vmd</a>
	#See also:
	# the VMD user's guide
	#Author: 
	# Andrew Dalke &lt;dalke@ks.uiuc.edu&gt;
	#Url: 
	# http://www.ks.uiuc.edu/Research/vmd/script_library/sscache/
	#\VMD  --- end of block
	
	
	# start the cache for a given molecule
	proc start_sscache {{molid top}} {
	    global sscache_data
	    if {! [string compare $molid top]} {
	set molid [molinfo top]
	    }
	    global vmd_frame
	    # set a trace to detect when an animation frame changes
	    trace variable vmd_frame($molid) w sscache
	    return
	}
	
	# remove the trace (need one stop for every start)
	proc stop_sscache {{molid top}} {
	    if {! [string compare $molid top]} {
	set molid [molinfo top]
	    }
	    global vmd_frame
	    trace vdelete vmd_frame($molid) w sscache
	    return
	}
	
	
	# reset the whole secondary structure data cache
	proc reset_sscache {} {
	    if [info exists sscache_data] {
	        unset sscache_data
	    }
	    return
	}
	
	# when the frame changes, trace calls this function
	proc sscache {name index op} {
	    # name == vmd_frame
	    # index == molecule id of the newly changed frame
	    # op == w
	    
	    global sscache_data
	
	    # get the protein CA atoms
	    set sel [atomselect $index "protein name CA"]
	
	    ## get the new frame number
	    # Tcl doesn't yet have it, but VMD does ...
	    set frame [molinfo $index get frame]
	
	    # see if the ss data exists in the cache
	    if [info exists sscache_data($index,$frame)] {
		$sel set structure $sscache_data($index,$frame)
		return
	    }
	
	    # doesn't exist, so (re)calculate it
	    vmd_calculate_structure $index
	    # save the data for next time
	    set sscache_data($index,$frame) [$sel get structure]
	
	    return
	}	
	start_sscache $molid
}

proc lbl {selectionText {labelInfo {resname resid}} {labelPrefix " "} {color red} {size 1}} {;	# Labels each atom in the 'selectionText' with information 'labelInfo', with arbitrary prefix 'labelPrefix', color 'color' and font size 'size' (default 1)
	if {![llength $selectionText]} {set selectionText "name CA"}
	if {![llength $labelInfo]} {set labelInfo {resname resid}}
	if {![llength $labelPrefix]} {set labelPrefix " "}
	if {![llength $color]} {set color red}
	if {![llength $size]} {set size 1}
    set sel [atomselect top $selectionText]
    draw color $color
    foreach coord [$sel get {x y z}] labelContent [$sel get $labelInfo] {
	    # and draw the text
	    draw text $coord "$labelPrefix$labelContent" size $size
    }
}
