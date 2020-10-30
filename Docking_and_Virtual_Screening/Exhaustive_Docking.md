# Welcome to the Ramirez Lab Wiki – Exhaustive docking protocol

Here we use present a pipeline to perform exhaustive docking to find the most probable binding mode of a given ligand.
The protocol consits in:

## 1. Molecular dynamics simulations of the target (withput ligand) ##
In this tutorial we use the Human Acetylcholinesterase (AChE) as target, and the ligand is the co-crystalized drug galantamine (PDB code 4EY6). Before to proced, please modeled any missing residue in the structure. In our case we complete the missing residues **259 to 264 and 495 to 497**, and used only chain A of the crystallographic structure. After protein refinement, a 150 ns Molecular Dynamics (MD) simulation of the protein withput the ligand is performed to allow the side chaing of the binding site addopt diferent conformations. With this step we include protein-flexibility in our pipeline. To be sure that the binding site does not suffer mayor conformational changes, a posotional restriction to the protein backbone atoms is suggested (~ 1 kcal x mol<sup>-1</sup> x <span>&#8491;</span><sup>-2</sup>). 

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
*The PDBQT 0 file was renamed to the number 100

## 5. Running exhaustive docking 
To run the docking you need create in the same directory as vina executables an initial vina input.conf file, with the structure shown below, where you must specify the coordinates and dimensions of the gridbox (in angstroms). 

```receptor = aaa.pdbqt
ligand = ./ligands/ligand.pdbqt

center_x = -14.02269725
center_y = -43.66526825
center_z =  27.7049727143
size_x =  35
size_y =  30
size_z =  30


cpu = 8
num_modes = 10
```

Also, the files obtained in step 4 (100 PDBQTs) and the ligand in pdbqt format must be in the same directory. **It is important that the ligand file is called ligand.pdbqt.

First to define the name of the files, the **tar** variable must be replaced with the PDBQTs name without the numbers from 1 to 100 , in our case is rot-AChE_4EY6 (from rot-AChE_4EY6_99,pdbqt). Also, In order to sort the input and output files established directories will be created, using the follow commands.

```tar="rot-AChE_4EY6" 
mkdir ligands
mv ligand.pdbqt ligands
mkdir all
mkdir all/results
mkdir all/results/output
mkdir all/results/all_mol2
```

For each pdbqt from 1 to 100 it's going to create a vina configuration file (input.conf) with the parameters spicified above and will rename it to read the corresponding target pdbqt. Then it will run the first docking from which you will get 10 poses as result, which will be separated in different pdbqt files using vina_split and will be used as new input files to obtain a total of 1000 different poses. Each obtained result will be in pdbqt and mol2 format.

```bash 
for s in {1..100}
	do	
		cp input "$tar"_$s.conf
		co="$tar"_"$s"
		perl -pi -e "s[aaa]["$co"]g" "$co".conf
		mkdir "$co"
		mkdir "$co"/output/
		mkdir "$co"/pdbqt/
		mkdir "$co"/pdbqt/split/
    
		./vina --config "$co".conf --out ./"$co"/pdbqt/"$co"_1.pdbqt > ./"$co"/output/output_1.log             ### To Carry out the first Docking to obtain 10 poses
  	./vina_split --input ./"$co"/pdbqt/"$co"_1.pdbqt --ligand ./"$co"/pdbqt/split/"$co"_                   ### Split the 10 poses from docking 1 into 10 new files
    obabel ./"$co"/pdbqt/split/*.pdbqt -omol2 -m                                                           ### Convert .pdbqt from the results into .mol2 files to be analysed 	
		mv "$co" all/results/output
done 
````

## 6. Clustering of conformers
In order to be able to analyze the results, all mol2 obtained files will be saved in a single mol2 file, to subsequently create the clusters according to RMSD criteria using conformer_cluster.py script from schrodinger suite.
            
````$SCHRODINGER/utilities/structcat -i *.mol2 -o ./all/results/all.mol2                               ### Concat all .mol2 files into a single file
mv *.mol2 ./all/results/all_mol2

$SCHRODINGER/run conformer_cluster.py -a ha -l Average -n 0 -j cluster_"$tar" -in_place -comb -keep_rmsd_file ./all/results/all.mol2 &                ##### Clustering of conformers: the conformer_cluster.py script from schrodinger suite will be used to clustering the docking conformers based in the RMSD. To see all options open the help menu as: $SCHRODINGER/run conformer_cluster.py -h 
```` 
Finally, just to order the following commands can be executed. 

````sleep 20s
mkdir all/input
mkdir all/input/conf
mkdir all/input/targets
mkdir ./all/results/cluster
mv cluster* ./all/results/cluster
mv *.pdbqt ./all/input/targets
mv *.conf ./all/input/conf
mv ligands ./all/input
````
