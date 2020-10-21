# Welcome to the Ramirez Lab Wiki – Exhaustive docking protocol

Here we use present a pipeline to perform exhaustive docking to find the most probable binding mode of a given ligand.
The protocol consits in:

## 1. Molecular dynamics simulations of the target (withput ligand) ##
In this tutorial we use the Human Acetylcholinesterase (AChE) as target, and the ligand is the co-crystalized drug galantamine (PDB code 4EY6). Before to proced, please modeled any missing residue in the structure. In our case we complete the missing residues **XXX** to **XXX** (Falta revisar con Lily) and used only chain A of the crystallographic structure. After protein refinement, a 150 ns Molecular Dynamics (MD) simulation of the protein withput the ligand is performed to allow the side chaing of the binding site addopt diferent conformations. With this step we include protein-flexibility in our pipeline. To be sure that the binding site does not suffer mayor conformational changes, a posotional restriction to the protein backbone atoms is suggested (~ 1 kcal x mol<sup>-1</sup> x <span>&#8491;</span><sup>-2</sup>). 

Here we use the Desmond software (available without cost for non-commercial at https://www.deshawresearch.com/downloads/download_desmond.cgi/) and some Schrödinger scripts (available after Desmond instalation) to process the trajectory. The suggested production time is 150ns, here we employed the last 100ns.

## 2. Structures extraction from MDs ##
Extract and pre-aling target PDBs (AChE_4EY6) from the last 100ns of the MDs (100 frames from 50 to 100 ns). To do that we use the *trj2mae.py* script (avalilable with your Desmond instalation). In this example our 150ns-MDs is composed by 1000 frames, so we extracted and prealignet the protein from frame 300 to 1000. To see the help menu of the *trj2mae.py* script use:
> $SCHRODINGER/run trj2mae.py -h

Please navegate to the folder where your MDs files are (you need the *simulation.out-cms* file as well as the *simulation_trj* trajectory file as positional arguments) and run the followng lines:

```bash
mkdir 2_frames_AChE_4EY6
cd 2_frames_AChE_4EY6
$SCHRODINGER/run trj2mae.py ../*-out.cms ../*_trj/ AChE_4EY6 -s 300:1000:7 -extract-asl protein -align-asl backbone -separate -out-format PDB
cd ..
```

The ouput PDBs files must be written at the *2_frames_AChE_4EY6* folder, and start from *AChE_4EY6_0.pdb* to *AChE_4EY6_99.pdb*. 

## 3. Alignmet of the target structures ## 
All the extracted structures must to be aligned to a reference target structure to ensure that the docking results all fall into the same binding site coordinates. Here we use the original protein we used to set the MD (*reference_AChE-4EY6.pdb*) to align all the extracted target PDBs (which is located into the *2_frames_AChE_4EY6* folder, and the utility *structalign* from Maestro (avalilable with your Desmond instalation). To see the help menu of the utility *structalign* use:
> $SCHRODINGER/utilities/structalign -h

Please run the following lines to aling the PDBs:

```bash
mkdir ./2_frames_AChE_4EY6/Structural_Alignment
cd 2_frames_AChE_4EY6/Structural_Alignment
$SCHRODINGER/utilities/structalign ../reference_AChE-4EY6.pdb ../AChE_4EY6_* > output.txt
```

The ouput alinged PDBs files must be written at the *Structural_Alignment* folder, and start from *rot-AChE_4EY6_0.pdb* to *rot-AChE_4EY6_99.pdb*. The *output.txt* contained the sequence alignmet as well as the RMSD values for each PDB aligned against the *reference_AChE-4EY6.pdb*.

## 4. Target PDBs preparation to dock ligand ##
The docking simulation will be performed with Autodock vina, so we need to convert the aligned PDBs to PDBQTs files. To do that we will employed *Open Babel* (http://openbabel.org/wiki/Main_Page). You can installed with conda as follows:
> conda install -c openbabel openbabel

Please be sure you are in the folder where the aligned PDBs are, create a copy of the aligned PDBs to the folder *PDBQTs* and convert the files as follows:
```bash
mkdir PDBQTs
cp *.pdb PDBQTs/
cd PDBQTs
obabel *.pdb -opdbqt -m -p 7.4 -xr
```
Aca te toca seguir Lily

