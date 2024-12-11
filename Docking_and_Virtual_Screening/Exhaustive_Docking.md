# Welcome to the Ramirez Lab Wiki – Exhaustive docking protocol

We present a pipeline to perform exhaustive docking to find the most probable binding conformation for a given ligand.
The protocol consits in:

## 1. Molecular dynamics simulations of the target (withput ligand) ##
In this tutorial we use the Human Acetylcholinesterase (AChE) as target with the co-crystalized ligand and drug galantamine (PDB code 4EY6). Before to proced, please model any missing residue in the structure. In our case we complete the missing residues **XXX** to **XXX** (Falta revisar con Lily) and used only chain A of the crystallographic structure. After protein refinement, a 150 ns Molecular Dynamics (MD) simulation of the protein with the ligand is performed to allow the side chain of the binding site adopt diferent conformations. With this step we include protein-flexibility in our pipeline. To be sure that the binding site does not suffer mayor conformational changes, a positional restriction to the protein backbone atoms is suggested (~ 1 kcal x mol<sup>-1</sup> x <span>&#8491;</span><sup>-2</sup>). 

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
## 5. Exhaustive Docking ##
#variables
lig="ligand_file" #nombre del ligando con extensión en pdbqt
name_system="example" #nombre del sistema
#creando la capeta para el ligando preparado
mkdir ligands
mv $lig ligands
#ESTO ES XQ VINA NO ESTA EN LA PATH
export PATH=$PATH:/home/larrue/Eu/autodock/

#genrando carpetas en orden
mkdir $name_system

mkdir $name_system/input
mkdir $name_system/input/targets
mkdir $name_system/input/conf

mkdir $name_system/results
mkdir $name_system/results/output
mkdir $name_system/results/all_mol2

mkdir $name_system/results/cluster
mkdir $name_system/results/cluster/all_mae

# For each pdbqt from 1 to 100 it's going to create a vina configuration file (input.conf)  and rename it to read the corresponding target pdbqt.
for s in *.pdbqt
do	
#se cambian los nombres de los archivos de ocnfiguración
sed "s/RECEPTOR/"${s}"/g" input > "${s%.*}".conf
mkdir "${s%.*}"
mkdir "${s%.*}"/output/
mkdir "${s%.*}"/pdbqt/
mkdir "${s%.*}"/pdbqt/split/

### Carry out the first Docking to obtain 10 poses
#poner el vina en la path
vina --config "${s%.*}".conf --out ./"${s%.*}"/pdbqt/"${s%.*}".pdbqt > ./"${s%.*}"/output/output.log

### Split the 10 poses from docking 1 into 10 new files
#poner el vina en la path
vina_split --input ./"${s%.*}"/pdbqt/"${s%.*}".pdbqt --ligand ./"${s%.*}"/pdbqt/split/"${s%.*}"_

### Convert .pdbqt from the results into .mol2 files to be analysed 	
obabel ./"${s%.*}"/pdbqt/split/*.pdbqt -omol2 -m 
mv "${s%.*}" $name_system/results/output
done 

#Pasar de MOL2 a MAE en ./all/results/all_mol2
for i in *.mol2
do
$SCHRODINGER/utilities/mol2convert -imol2 ${i} -omae ${i%.*}.mae
done

#Agregar Hidrogenos

for i in *.mae
do
$SCHRODINGER/utilities/prepwizard -noepik -noprotassign -nopropka -noimpref ${i} ${i%.*}-Hs.mae
done

#Para agregar cargas parciales con campo de fuerza OPLS2005

for i in *-Hs.mae
do
$SCHRODINGER/utilities/ffld_server -imae ${i%.*}.mae -omae ${i%.*}-charged.mae -version 2005
done

#reuniendo todos los nuevos mae
cat *-charged.mae > all-charged.mae


### Clustering of conformers: the conformer_cluster.py script from schrodinger suite will be used to clustering the docking conformers based in the RMSD. To see all options open the help menu as: $SCHRODINGER/run conformer_cluster.py -h 
$SCHRODINGER/run conformer_cluster.py -a ha -l Average -n 0 -j $name_system -in_place -comb -keep_rmsd_file all-charged.mae &

#poner un condicional cuando el proceso se acaba para lo de abajo

### Just to order
sleep 60s

mv ligands $name_system/input
mv *.pdbqt $name_system/input/targets
mv *.conf $name_system/input/conf

mv *.mol2 $name_system/results/all_mol2

mv  *.log *.mae $name_system/results/cluster/all_mae
mv *cluster* *$name_system*.* $name_system/results/cluster

