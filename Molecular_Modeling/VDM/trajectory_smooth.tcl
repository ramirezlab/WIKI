# source ~/vmd/tclproc/statistics.tcl 

# SMOOTHING A TRAJECTORY
#---------------------------
# sliding_avg_pos $sel $width $file [beg $firstframe] [end $lastframe] 
# [restore 1/0] [crop 0/1]

# Computes the average position in $width frames of the atoms in the 
# selection $sel and moves this sliding window through time. Let's say 
# you choose a window of width 7, then the current frame, the three 
# preceding ones and the three following frames are used to compute the 
# average position. This results in a smoothed trajectory which will be 
# saved as dcd with the name $file.

# Depending on the window size you will be able to see net movements of 
# residues and get rid of some of the thermal noise.

# You can limit the averaging to specified frames using the 
# 'beg $firstframe' and 'end $lastframe' options. Instead of $lastframe 
# you can simply type 'last' if you mean the last frame of the loaded 
# dcd trajectory. 
# Note that your original trajectory is transformed into the averaged 
# one, you can automatically reload the original using the 'restore 1'
# option.
# Through the option 'crop 1' you can automatically crop the trajectory 
# to the size specified in the beg/end statements

# The averaging procedure effects only the selection you specified, so 
# might get strange atom distances at the fringes. Therefore you should 
# include everything you want to look at in the selection. But careful,
# it could become quite slow then. (for rhodopsin with about 5600 atoms
# it takes about 1-2 seconds per frame on my linux box)

# examples:
# set sel [atomselect top "protein"]
# sliding_avg_pos $sel 9 slide_prot10.dcd beg 0 end 100 crop 1
# sliding_avg_pos $sel 9 slide_prot10.dcd beg 0 end last restore 1

proc sliding_avg_pos {sel width file args} {
    set first 0
    set last last
    set mol [$sel molid]
    set restore 0
    set crop 0

    foreach {i j} $args {
	if {$i=="beg"} then { set first $j }
	if {$i=="end"}  then { set last $j }
	if {$i=="restore"} then { set restore $j }
	if {$i=="crop"} then { set crop $j }
    }
    if { [expr fmod($width,2)] == 0.0 } then {
	puts "ERROR: Window size must be an odd number to get a symmetric window."
	puts "Try again."
	return 0
    }

    puts "Transforms this dcd file into avg trajectory and writes new file."

    set numframes [molinfo $mol get numframes]
    if {$last=="last"} then {set last [expr $numframes-1]}
    
    # initialize vector $oldsum
    set oldsum ""
    for {set i 0} {$i < [$sel num]} {incr i} {
	lappend oldsum {0 0 0}
    }
    set zerolist $oldsum

    # initialize $sum and $coordbuf
    set fcount 0
    set coordbuf ""
    set hwidth [expr ($width-1)/2] 
    for {set frame [expr $first-$hwidth]} {$frame < [expr $first+$hwidth]} {incr frame} {
	if {$frame>=0} then {	
	    $sel frame $frame
	    set coords [$sel get {x y z}]
	    set sum ""
	    foreach atom $coords osum $oldsum {
		lappend sum [vecadd $osum $atom]
	    }
	    set oldsum $sum
	    incr fcount

	    # initialize the coordinate buffer:
	    # I must store the frames of the fist half of the window in a buffer
	    # because the center frame will be overwritten with the new avg positions
	    # of the window.
	    if {$frame<$first} then {
		lappend coordbuf $coords
	    }
	}
    }

    # get the avgpos for every slice:
    for {set slice $first} {$slice<$last} {incr slice} {
	puts $slice

	# get coords which will be subtracted from $sum
	if {$slice>=[expr $first+$hwidth]} then {
	    $sel frame [expr $slice-$hwidth]
	    set subcoords [lindex $coordbuf 0]
	    incr fcount -1

	    # remove the coords from the coordinate buffer
	    lvarpop coordbuf
	} else { set subcoords $zerolist }

	# get the coords which will be added to sum
	if {$slice<=[expr $last-$hwidth]} then {
	    $sel frame [expr $slice+$hwidth]
	    set addcoords [$sel get {x y z}]
	    incr fcount
	} else { set addcoords $zerolist }

	# update the coordinate buffer with the coordinates added
	$sel frame $slice
	lappend coordbuf [$sel get {x y z}]

	# update $sum
        set addsum ""
	set sum ""
	foreach addatom $addcoords subatom $subcoords osum $oldsum {
	    if {$slice<[expr $first+$hwidth]} then {
		# ramp it up
		lappend sum [vecadd $osum $addatom]
	    } elseif {$slice>[expr $last-$hwidth]} then {
		# ramp it down
		lappend sum [vecsub $osum $subatom]
	    } else {
		# add and substract frame data
		lappend sum [vecsub [vecadd $osum $addatom] $subatom]
	    }
	}
	set oldsum $sum

	# scale the vector
	if {$slice<[expr $first+$hwidth]} then {
	    set scale [expr 1.0/($hwidth+$slice+1)]
	} elseif {$slice>[expr $last-$hwidth]} then {
	    set scale [expr 1.0/($hwidth+$last-$slice-1)]
	} else { set scale [expr 1.0/($width)] }
	set scale [expr 1.0/$fcount]
	set avgpos ""
	foreach atom $sum {
	    lappend avgpos [vecscale $atom $scale]
	}

        # set the new positions:
	$sel frame $slice
	$sel set {x y z} $avgpos 
    }

    if {$crop==1} then {
	# delete the frames after $last:
	puts "deleting frames [expr $last+1] to [expr $numframes+1]"
	animate delete beg [expr $last+1] end $numframes
	#crop the unused frames at the beginning
	if { $first>0 } then { 
	    puts "deleting frames 0 to $first"
	    animate delete beg 0 end $first 
	}
    }
    
    # write a new dcd file with the avg positions
    animate write dcd $file beg 0 waitfor all

    puts "Your original file was transformed to avg coordinates."
    puts "It contains [molinfo $mol get numframes] frames.\n"

    if {$restore} {
	# load the original file:
	puts "Reloading the original trajectory with:"
	puts "> mol load psf [molinfo $mol get filename] dcd [molinfo $mol get filename2]"
	mol load psf [molinfo $mol get filename] dcd [molinfo $mol get filename2]
	puts "It has molid [molinfo top get id]"
    } else {
	puts "You can reload the original trajectory with:"
	puts "> mol load psf [molinfo $mol get filename] dcd [molinfo $mol get filename2]"
    }
}


# COMPUTE THE AVERAGE POSITIONS
# -------------------------------
# This procedure works similar as 'sliding_avg_pos' but it does not 
# slide the window, it generates only one frame with the average 
# positions of the selection between 'beg $firstframe' and 'end $lastframe'
# and returns them. Optionally they can be saved as a pdb file with the name 
# $file.
# After the 'writesel' keyword you can specify which atoms you want to save 
# in the pdb file:
# 'writesel none'    - no pdb file is written 
# 'writesel selonly' - only the selected atoms are written
# 'writesel all'     - all atom are written

# examples:
# set sel [atomselect top "index 44 to 67"]
# set avgpos [avg_position $sel avgpos.pdb beg 0 end last writesel selonly]
# mol load pdb avgpos.pdb

# You can compute the mean square deviation using:
# set dev [dev_pos $sel $avgpos]
# mean $dev

proc avg_position { sel file args } {
    set first 0
    set last last
    set mol [$sel molid]
    set writesel none
    set restore 0
    foreach {i j} $args {
	if {$i=="beg"} then { set first $j }
	if {$i=="end"}  then { set last $j }
	if {$i=="writesel"}   then { set writesel $j }
	if {$i=="restore"} then { set restore $j }
    }
    #draw delete all
    if {$last=="last"} then {set last [expr [molinfo $mol get numframes]-1]}
    set numatoms [$sel num]
    set oldsum ""
    for {set i 0} {$i < $numatoms} {incr i} {
	lappend oldsum {0 0 0}
    }
    for {set frame $first} {$frame <= $last} {incr frame} {
	$sel frame $frame
	set coords [$sel get {x y z}]
        set sum ""
	foreach atom $coords osum $oldsum {
	    lappend sum [vecadd $osum $atom]
	}
	set oldsum $sum
    }
    set scale [expr 1.0/($last-$first+1)]
    #puts $scale
    set avgpos ""
    foreach atom $sum {
	lappend avgpos [vecscale $atom $scale]
    }
    #draw color yellow
    #draw arrow {0 0 0} [lindex $avgpos 5]
    
    # write avg positions to pdf-file
    if {$writesel=="all"} {
	$sel frame 0
	set storepos [$sel get {x y z}]
	$sel lmoveto $avgpos
	set all [atomselect $mol "all"]
	$all writepdb $file
	$sel lmoveto $storepos
    } elseif {$writesel=="selonly"} {
	$sel frame 0
	set storepos [$sel get {x y z}]
	$sel lmoveto $avgpos
	$sel writepdb $file
	$sel lmoveto $storepos
    }
    return $avgpos
}


# Takes avg positions as input and computes the mean square deviation

proc dev_pos { sel avgpos args } {
    set first 0
    set last last
    set mol [$sel molid]
    foreach {i j} $args {
	if {$i=="beg"} then { set first $j }
	if {$i=="end"}  then { set last $j }
    }

    if {$last=="last"} then {set last [molinfo $mol get numframes]}
    if {[llength $avgpos] != [$sel num]} {
	puts "ERROR: Selection and avgpos don't have same size!"
	puts "[llength $avgpos]"
	puts "[$sel num]"
	return 0
    }
    for {set frame $first} {$frame <= $last} {incr frame} {
	$sel frame $frame
	set coords [$sel get {x y z}]
	set oldmeandev2 ""
        set meandev2 ""
	for {set i 0} {$i < [$sel num]} {incr i} {
	    lappend oldmeandev2 0 
	}
	set i 0
	foreach atom $coords mean $avgpos {
	    set dev2 [expr pow([veclength [vecsub $atom $mean]], 2)]
	    lappend meandev2 [expr [lindex $oldmeandev2 $i] + $dev2]
	    incr i
	}
	set oldmeandev2 $meandev2
    }
    return $meandev2
}

# Just computes the mean value of a list of values
proc mean { x } {
    set len [llength $x]
    set sum 0
    foreach e $x {
	set sum [expr $sum+$e]
    }
    return [expr $sum/$len]
}

# Computes the average dihedral angle of a bond
# (takes the indices of the four dihedral atoms as input)
proc avg_angle { a1 a2 a3 a4 {first 0} {last last}} {
  if {$last=="last"} then {set last [molinfo top get numframes]}
#  set dihed [atomselect top "index $a1 $a2 $a3 $a4"]
  set sel1 [atomselect top "index $a1"]
  set sel2 [atomselect top "index $a2"]
  set sel3 [atomselect top "index $a3"]
  set sel4 [atomselect top "index $a4"]
  set sum 0
  for {set frame $first} {$frame < $last} {incr frame} {
    $sel1 frame $frame
    $sel2 frame $frame
    $sel3 frame $frame
    $sel4 frame $frame
    set coord1 [lindex [$sel1 get {x y z}] 0]
    set coord2 [lindex [$sel2 get {x y z}] 0]
    set coord3 [lindex [$sel3 get {x y z}] 0]
    set coord4 [lindex [$sel4 get {x y z}] 0]
    set v1 [vecsub $coord1 $coord2] 
    set v2 [vecsub $coord3 $coord2]
    set v3 [vecsub $coord4 $coord3]
    set cross1 [vecnorm [veccross $v2 $v1]]
    set cross2 [vecnorm [veccross $v2 $v3]]
    set dot [vecdot $cross1 $cross2]
    set angle [expr acos($dot)]
    set sum [expr $sum + $angle]
  }
    set avgangle [rad2deg [expr $sum/($last+1)]]
  puts "$frame $avgangle"
}

# Computes the dihedral angle of a bond
# (takes the indices of the four dihedral atoms as input)
proc dihed_angle { a1 a2 a3 a4 } {
  set dihed [atomselect top "index $a1 $a2 $a3 $a4"]
  set coord1 [lindex [[atomselect top "index $a1"] get {x y z}] 0]
  set coord2 [lindex [[atomselect top "index $a2"] get {x y z}] 0]
  set coord3 [lindex [[atomselect top "index $a3"] get {x y z}] 0]
  set coord4 [lindex [[atomselect top "index $a4"] get {x y z}] 0]
  set v1 [vecsub $coord1 $coord2] 
  set v2 [vecsub $coord3 $coord2]
  set v3 [vecsub $coord4 $coord3]
  # draw delete all
  # draw color red
  # draw arrow $coord2 [vecadd $coord2 $v1]
  # draw arrow $coord2 [vecadd $coord2 $v2]
  # draw color green
  # draw arrow $coord3 [vecadd $coord3 [vecinvert $v2]]
  # draw arrow $coord3 [vecadd $coord3 $v3]
  set cross1 [vecnorm [veccross $v2 $v1]]
  set cross2 [vecnorm [veccross $v2 $v3]]
  # draw color yellow
  # draw arrow $coord3 [vecadd $coord3 $cross2]
  # draw arrow $coord2 [vecadd $coord2 $cross1]
  set dot [vecdot $cross1 $cross2]
  set angle [rad2deg [expr acos($dot)]]
  return $angle
}

# Computes the angle between two vectors x and y
proc vecangle {x y} {
    if {[llength $x] != [llength $y]} {
        error "vecangle needs vectors of the same size: $x : $y"
    }
    set ret 0
    foreach t1 $x t2 $y {
        set ret [expr $ret + $t1 * $t2]
    }
    return [rad2deg [expr (acos($ret/([veclength $x] * [veclength $y])))]]
}

proc deg2rad { deg } {
  return [expr ($deg/180*3.14159265)]
}

proc rad2deg { rad } {
  return [expr ($rad/3.14159265)*180]
}
