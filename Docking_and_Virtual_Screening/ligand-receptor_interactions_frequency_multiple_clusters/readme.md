# Welcome to the Ramirez Lab Wiki - Docking post-processing: Interaction frequency among multiple-cluster conformers #

To analyze the frequency of receptor-ligand interactions on a set of poses from different clusters, we use scripts included on Schrödinger Suit (v.2020-3) to calculate the interactions on every pose and a *in-house* functional workflow built on Knime to get the frequency of interactions on each cluster and then sum the total.

## Requirements ##
- [Schrödinger](https://www.schrodinger.com/) Suit (version 2020 or newer; comercial or academic version).
- [Knime](https://www.knime.com/) version 4.3.2 or higher, a programing software via functional workflows.
- Our *in-house* Knime workflow to calculate interaction frequencies. [Cluster-interactions-frequency](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/04_cluster_interactions_frequency.knwf).
- A set of receptor-ligand complexes from a single cluster. All complexes must be of the same receptor and ligand. They can be obtained from different docking simulations, from a molecular dynamics trajectory, or even from free energy calculations.
To test this pipeline, skipping steps 1 and 2, we provide an example ready for the workflow, with 7 clusters with all interactions already calculated (*csv* files), and separated into different folders. [Example cluster set](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/03_System1_7clusters_example_set.zip).

## 1. Split receptor-ligand complex from single clsuter into separate files ##

To make sure that receptor and ligand are being use as input in correct order we first split the receptor-ligand complexes into two separate files using the *split_structure.py* script from [Schrödinger scripts](https://www.schrodinger.com/scriptcenter). This can be done to all complex within a folder writing and executing the following bash script:

***split.awk***
```bash
echo "Processing data ..."

for f in *.maegz; do
    $SCHRODINGER/run split_structure.py ${f} -m ligand -k -many_files ${f%.maegz}.mae    
done

echo "Done!!"
```

Execute on a terminal with:
````
$ ./split.awk
````
For more information about the script options you can type in the terminal:
````
$ $SCHRODINGER/run split_structure.py -h
````
## 2. Calculate interactions between ligand and receptor residues ##

To calculate the interactions between receptor and ligand we use  the *poseviewer_interactions.py* script (Schrödinger suit version 2020-1). When setting inputs make sure to give first the receptor and then the ligand file, followed by "-csv" to also export the results on a *csv* format file. You can calculate the interactions on all the previously split files by writing the next script:

***poseviewer.awk***  
```bash
echo "Processing data ..."

for f in *_receptor1.mae; do
$SCHRODINGER/run poseviewer_interactions.py ${f} ${f%_receptor1.mae}_ligand1.mae -csv  
done

echo "Done!!"
```

Execute on a terminal with:
````
$ ./poseviewer.awk
````
For more information about the script options you can type in the terminal:

````
$ $SCHRODINGER/run poseviewer_interactions.py -h
````

## 3. Split clusters into folders ##

Make sure that each cluster has their own separated directory containing interactions files (*.csv).
````
$ ls
cluster1  cluster2  cluster3  cluster4  cluster5  cluster6  cluster7
$ tree
.
└── System1
    ├── cluster1
    │   ├── 174_pv_interactions.csv
    │   ├── 181_pv_interactions.csv
    │   ├── 183_pv_interactions.csv
    │   ├── 271_pv_interactions.csv
    │   ├── 272_pv_interactions.csv
    │   ├── ...
    ├── cluster2
    │   ├── 1001_pv_interactions.csv
    │   ├── 107_pv_interactions.csv
    │   ├── 108_pv_interactions.csv
    │   ├── 109_pv_interactions.csv
    │   ├── 117_pv_interactions.csv
    │   ├── ...
    ├── cluster3
    │   ├── 12_pv_interactions.csv
    │   ├── 13_pv_interactions.csv
    │   ├── 143_pv_interactions.csv
    │   ├── 144_pv_interactions.csv
    │   ├── 145_pv_interactions.csv
    │   ├── ...
    └── ...
````
## 4. Calculate interaction frequencies for user defined ligand fragments ##

To calculate the interaction frequency of each ligand-receptor complex cluster we use the Knime workflow [Multiple_clusters_interactions_frequency](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/04_Multiple-Clusters_interactions_frequency.knwf). The user must to configure 2 nodes:
- **List Files/Folders:** The user must select the parent folder where separated cluster directories are located.
- **Table Creator:** The user need to list all ligand atoms **(use only PDB format atom names)** on the first column, and assign each atom to the fragment of the structure it belongs to. Visit [Interaction frequency among single-cluster conformers](https://github.com/ramirezlab/WIKI/tree/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency) for an example of maping ligands.


<p align="center">
    <img src="https://raw.githubusercontent.com/ramirezlab/WIKI/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/media/WF_multiple_clusters_interaction_frequency.png" width="900">
</p>

Example of ligand fragment naming on table creator node:

<p align="center">
    <img src="https://raw.githubusercontent.com/ramirezlab/WIKI/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/media/maping_mix.jpg" width="700">
</p>


## 5. Results ##

The results table shows ligand framents, interacting residues and the sum of frequencies of clusters. [Download results file](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/05_results.xlsx)

<p align="center">
    <img src="https://raw.githubusercontent.com/ramirezlab/WIKI/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/media/05_Results.png" width="900">
</p>

## Citing
