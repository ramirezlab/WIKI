#!/usr/bin/env bash

# Glide docking ensemble executor

# 1. Pass the mae or maegz files with the pre-aligned protein structures.
# 2. Grid generation and docking calculation

# Use as 
# ./ensemble_docking_001.sh /path-to-structures/*.maegz
# or if you rather to release the console use as:
# ./ensemble_docking_001.sh /path-to-structures/*.maegz > out.log &disown 


# Glide path
SCHRODINGER_GLIDE="/path-to-schrodinger/glide"

# Grid parameters
GRID_CENTER="xx, xx, xx"
INNERBOX="10, 10, 10"
OUTERBOX="20, 20, 20"

# Docking parameters
ligand="ligand.maegz"
# Primary
POSES_PER_LIG="10"
PRECISION="SP"
# Extra
EXPANDED_SAMPLING="True"
FORCEPLANAR="False"
NENHANCED_SAMPLING="4"
POSE_DISPLACEMENT="0.0"
POSE_RMSD="0.0"
POSTDOCK_NPOSE="20"
POSTDOCKSTRAIN="True"

# Processors and host to use in each task
processors=1
HOST="localhost:$processors"

# Grid generation
total=$#
count=0
for F in "$@"; do
    count=$((count+1))
    basename=$(basename $F)
    basename=${basename%.*}
    printf "Generating grid $basename ($count/$total)..."
    printf "\n"
    cat > grid_$basename.in <<- EOS
GRID_CENTER         $GRID_CENTER
GRIDFILE            grid_$basename.zip
INNERBOX            $INNERBOX
OUTERBOX            $OUTERBOX
RECEP_FILE          $F
EOS

    $SCHRODINGER_GLIDE "grid_$basename.in" -HOST "$HOST" -WAIT > /dev/null 2>&1

    cat > dock_$basename.in <<- EOS
EXPANDED_SAMPLING   $EXPANDED_SAMPLING
FORCEPLANAR         $FORCEPLANAR
GRIDFILE            grid_$basename.zip
LIGANDFILE          $ligand
NENHANCED_SAMPLING  $NENHANCED_SAMPLING
POSE_DISPLACEMENT   $POSE_DISPLACEMENT
POSE_RMSD           $POSE_RMSD
POSES_PER_LIG       $POSES_PER_LIG
POSTDOCK_NPOSE      $POSTDOCK_NPOSE
POSTDOCKSTRAIN      $POSTDOCKSTRAIN
PRECISION           $PRECISION
EOS
    printf "Running docking $basename ($count/$total)..."
    printf "\n"
    $SCHRODINGER_GLIDE -HOST "$HOST" "dock_$basename.in" -WAIT > /dev/null 2>&1
done