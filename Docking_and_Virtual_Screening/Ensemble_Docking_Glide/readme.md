# Welcome to the Ramirez Lab Wiki – Ensemble docking with Glide

Here we use present a pipeline to perform ensemble docking to find the most probable binding mode of a given ligand in a given set (ensemble) of protein structures.
The protocol consists in:

## 1. Molecular dynamics simulations of the target protein (without ligand) ##
After a proper equilibration of the protein, a molecular dynamics simulation should be performed. We suggest generating 100 ns of Molecular Dynamics (MD) simulation of the protein in the apo form to produce an ensemble of protein conformations for subsequent molecular docking calculation. With this step we include protein-flexibility in our pipeline. To be sure that the binding site does not suffer mayor conformational changes, a positional restriction to the protein backbone atoms is suggested (~ 0.5 - 1.0 kcal x mol<sup>-1</sup> x <span>&#8491;</span><sup>-2</sup>). 

Here we use the Desmond software (available without cost for non-commercial use at https://www.deshawresearch.com/downloads/download_desmond.cgi/) and some Schrödinger scripts (available after Desmond instalation) to process the trajectory.

## 2. Structures extraction from MD ##
Extract and pre-align target frames from the 100ns of the MD (100 frames, 1 frame per ns). To do that we use the *trj2mae.py* script (avalilable at the Desmond installation). In this example the 100ns-MDs is composed by 1000 frames, so we extracted and prealigned the protein from frame 0 to 1000. To see the help menu of the *trj2mae.py* script use:
> $SCHRODINGER/run trj2mae.py -h

1. Go to the directory where the 100ns-MD is stored.
2. Run the followng commands:

```bash
mkdir 1_structures; cd 1_structures
$SCHRODINGER/run trj2mae.py ../*-out.cms ../*_trj/ apo -s 0:1000:10 -extract-asl "protein" -align-asl "backbone_binding_site" -separate -out-format MAE
cd ..
```
The above command will read the path from frame 0 to 1000 and extract the frames every 10th. The basename will be: "apo".
The ouput maegz files must be written at the *1_structures* folder, and start from *apo_0.maegz* to *apo_99.maegz*. 
The option -align-asl, will be the selection in ASL format that will be used to align the structures. In this step the structures must be aligned by taking the backbone of the binding site residues, for instance, for residues 1, 2, 3, 4, and 5 of chain A and residues 8 and 9 of chain B the following ASL selection should be used:
"(((chain.name A) AND (res.num 1,2,3,4,5)) OR ((chain.name B) AND (res.num 8,9))) AND (( backbone ))"


## 3. Docking calculation ##
The docking calculation will be performed with the Glide software available in the Schrödinger suite software.
As the target structures are pre-aligned, the same center of the grid could be assigned for all the structures. To calculate the center of the grid, one or more structures can be taken and an average of its binding-site center can be carried out. With the following commands, the center of the binding site could be calculated using the TKConsole of the VMD software. You must first load the structure in VMD and then run in the TKConsole:

```tcl
set selection "(chain A and resid 1 2 3 4 5 or chain B and resid 1 2) and backbone"
measure center [atomselect top "($ selection)"]
```

The docking parameters of the ensemble_docking_glide.sh script must be adjusted.
**NOTE:**
Remember to assign the correct path of the glide executable, the center of the grid, and size, the path, and the name of the ligand or ligands to be docked, the number of output poses for each ligand, and the number of processors to use in the calculation.

ensemble_docking_glide.sh:

```bash
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
```

Finally, with the next commands a new folder will be created, then, it should be executed the ensemble_docking_glide.sh script.

> mkdir 2_ensemble_docking; cd 2_ensemble_docking
> ./ensemble_docking_glide.sh ../1_structures/*maegz


Each grid and docking calculation will be executed for each structure consecutively. To parallelize the calculation, you can execute it several times selecting a certain number of frames, for example:


> ./ensemble_docking_glide.sh ../1_structures/apo_1*.maegz

The above command will run the docking calculation on structures starting with the name "apo_1".

To release the console you can run the script like this:

> ./ensemble_docking_glide.sh ../1_structures/*.maegz > out.log &disown
