# Welcome to the Ramirez Lab Wiki - Molecular Dynamics Simulations

Here we use a _tcl_ script to get the resdiues within a given distance of a ligand during a trajectory. You can use it to study Protein-Protein or Peptide-Protein interaction as well.
>Tip: If your MDs comes from Desmond, write both the coordinates.pdb  and trajectory.dcd files using VMD to then use this script. 

Usage: 
>vmd -dispdev text -e contacts.tcl -args pdb dcd distancia receptor ligando outDir

Example:
>vmd -dispdev text -e contacts.tcl -args My_Complex.pdb Me_Complex.dcd 4 protein "resname LIG" output_resdiues

#### contacts.tcl
```markdown
#!/usr/bin/tclsh
####################################################################################
############# Created by Melissa Alegria & David Ramirez - Ramirez Lab #############
####################################################################################
# Get arguments.
# "Usage: vmd -dispdev text -e contacts.tcl -args pdb dcd distancia receptor ligando outDir"
# "Example: vmd -dispdev text -e contacts.tcl -args My_Complex.pdb Me_Complex.dcd 4 protein "resname LIG" output_resdiues"

set pdb [lindex $argv 0]
set DCD [lindex $argv 1]
set distancia [lindex $argv 2]
set receptor [lindex $argv 3]
set ligando [lindex $argv 4]
set outName [lindex $argv 5]

echo "--------------------------------------------" 
echo "Loading trajectory $DCD ..." 
echo "--------------------------------------------" 

mol load pdb $pdb dcd $DCD

set nframes [molinfo top get numframes]

mkdir $outName

## Selection of residues from the receptor 
set sel [atomselect top "$receptor and same residue as within $distancia of ($ligando)"]

## Selection of CA from receptor
set sel2 [atomselect top "$receptor and name CA and same residue as within $distancia of $ligando"]

## Selection of ligand (If it is a Protein-Protein or Peptide-Protein interaction, comment the folloiwng line)
set sel3 [atomselect top "($ligando) and same residue as within $distancia of $receptor"]
set sel4 $sel3 

## If it is a Protein-Protein or Peptide-Protein interaction uncomment the following line 
#set sel4 [atomselect top "($ligando) and name CA and same residue as within $distancia of ($receptor)"]



set file [open $outName/residues-receptor.csv w]
set file2 [open $outName/number-receptor.csv w]
set file3 [open $outName/residues-ligand.csv w]
set file4 [open $outName/number-ligand.csv w]

puts $file2 "Frame,N Residue Contacts"
puts $file4 "Frame,N Residue Contacts"


echo "-----------------------------------------------------" 
echo "      Getting residues for $nframes frames " 
echo "-----------------------------------------------------" 


for {set i 0; set d 1} {$i < $nframes} {incr i; incr d} {

    # show activity
    if { [expr $d % 10] == 0 } {
      puts -nonewline "."
      if { [expr $d % 500] == 0 } { puts " " }
      flush stdout
    }
	
	$sel frame $i
	$sel2 frame $i
	$sel3 frame $i
	$sel4 frame $i
  	$sel update
  	$sel2 update
  	$sel3 update
	$sel4 update
	
	set protRes [lsort -unique [$sel get {resname resid}]]
	puts $file "$protRes"

	set protLig [lsort -unique [$sel3 get {resname resid}]]
	puts $file3 "$protLig"
	
	set num_residues [$sel2 num]
	puts $file2 "$i,$num_residues"
	
	set num_ligand [$sel4 num]
	puts $file4 "$i,$num_ligand"

}

close $file
close $file2
close $file3
close $file4

echo "Residue,Occurrence,Percentage" >$outName/residues-receptor_total.csv

#In the following line please repalce the **1002** by the total number of frames in your simulation.
cat $outName/residues-receptor.csv | tr '}' '\n' | sed s/.*\{//g | tr " " "_" | grep . | sort | sed s/\_//g | uniq -c | awk {{print $2","$1","$1*100/1002}} >>$outName/residues-receptor_total.csv 

quit
```

## Citing

* Melissa Alegria, & David Ramirez. (2020, October 15). Getting residues within a given distance of a ligand during a trajectory (Version 1.0). Zenodo. http://doi.org/10.5281/zenodo.4095515
* [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4095515.svg)](https://doi.org/10.5281/zenodo.4095515)





