# Welcome to the Ramirez Lab Wiki - Molecular Dynamics Simulations

Here we use a _tcl_ script to count the water molecules in an ion channel pore (or any pore) along a trajectory from AMBER, Desmond or NAMD. The pore of the ion channel must be aligned along the z-axis. The selection must be a cylinder.
 

Usage in VMD´s Tk console: 
>play  WatersCount.tcl


#### WatersCount.tcl
```markdown
#################################################################################
############# Created by Daniel Bustos & David Ramírez - Ramirez Lab #############
#################################################################################

# The selection must be a cylinder: e.g. set selection1 "(water and z < Hmax and z > Hmin and (x - xinitial)**2 + (y - yinitial)**2 < r^2) and name 0"
set selection1 "(water and z < 7 and z > -20 and (x -  5)**2 + (y - 30)**2 < 120) and name O"

# if you want print in a file
set output [open "waters.dat" w] 

#get number of frames	
set n [molinfo top get numframes]

puts "frame\t\twater molecules"

for {set i 0} {$i < $n} {incr i} {
	

	set sel [atomselect top "$selection1" frame $i]
	set wc [$sel get index]
	set count [llength $wc]

	# if you want print in console
	puts "$i\t\t$count"

	# if you want print in a file
	puts $output "$i\t\t$count"
	
}

close $output 
```

## Citing

* Daniel Bustos, & David Ramirez. (2020, October 13). Script to count the water molecules in an ion channel pore (or any pore) along a MD trajectory (Version 1). Zenodo. http://doi.org/10.5281/zenodo.4086113
* [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4086113.svg)](https://doi.org/10.5281/zenodo.4086113)


