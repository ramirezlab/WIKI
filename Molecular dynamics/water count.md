# Welcome to the Ramirez Lab Wiki - Molecular Dynamics Simulations

Here we use a _tcl_ script to count the water molecules in an ion channel pore (or any pore) along a trajectory from AMBER, Desmond or NAMD. The pore of the ion channel must be aligned along the z-axis. The selection must be a cylinder.
 

Usage in VMD tk console: 
>play  WatersCount.tcl


#### WatersCount.tcl
```markdown
##################################################################
############# Created by Daniel Bustos - Ramirez Lab #############
##################################################################

# The selection must be a cylinder
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


Thanks!!!

