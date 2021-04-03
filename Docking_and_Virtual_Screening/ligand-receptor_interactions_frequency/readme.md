# Welcome to the Ramirez Lab Wiki - Docking post-processing: Clustering and interactions analysis #
<!-- como tambien usamos este workflow para analizar las dinamicas de la tubulina creo que deberiamos cambiar el titulo de este proceso -->

To analyze the frequency of receptor-ligand interactions on a set of poses we use scripts included on Schrödinger Suit (v.2020-1) and *in-house* functional workflow built on [Knime](https://www.knime.com/).
## 1. Requirements ##
- Schrödinger Suit (version 2020 or newer; comercial or academic version) [Schrödinger](https://www.schrodinger.com/).
- Knime, a programing software via functional workflows. [Knime website](https://www.knime.com/).
- Our *in-house* Knime workflow to calculate interaction frequencies. [Cluster-interactions-frequency_v2.knwf](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/cluster_interactions_frequency_v2.knwf)
- A set of receptor-ligand complexes. All complexes must be of the same receptor and ligand. They can be obtained from different docking simulations, from a molecular dynamics trajectory, or even from free energy calculations. 
To test this pipeline we provide a example cluster with all interactions already calculated (*csv* files). [Example cluster set](https://github.com/ramirezlab/WIKI/tree/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/ligand-receptor_complex_example_set).

## 2. Split receptor-ligand complex into separate files ##

To make sure that receptor and ligand are being use as input in correct order we first split the receptor-ligand complexes into two separate files using the *split_structure.py* script from [Schrödinger](https://www.schrodinger.com/scriptcenter). This can be done to all complex within a folder writing and executing the following bash script:

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
For more information about the script options you can write in the terminal:
````
$ $SCHRODINGER/run split_structure.py -h
````
## 3. Calculate interactions between ligand and receptor ##

To calculate the interaction between receptor and ligand we use  the *poseviewer_interactions.py* script (Schrödinger suit version 2020-1). When setting inputs make sure to give first the receptor and then the ligand file, followed by "-csv" to also export the results on a *csv* format file. You can calculate the interactions on all the previously split files by writing the next script:

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
For more information about the script options you can write in the terminal:

````
$ $SCHRODINGER/run poseviewer_interactions.py -h
````
## 4. Calculate interaction frequencies for user defined ligand fragments ##
To calculate the interaction frequency of each ligand-receptor complex we use a Knime workflow. The user must to configure 3 nodes:
- **List Files/Folders:** The user must select the folder with all *csv files* with the interactions previously calculated (step 3).
- **Table Creator:** The user need to list all ligand atoms on the first column, and assign each atom to the fragment of the structure it belongs to.
- **Excel Writer:**  Finally, the user must configure a path to save the final file as an Excel datasheet.


![image1](https://github.com/ramirezlab/WIKI/blob/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/frequency_interactions_WF.png)

Example of ligand fragment naming on table creator node:

![image2](https://github.com/ramirezlab/WIKI/blob/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/lig_fragment_config.png)

## 5. Results ##
The results table shows ligand framents, which resudue is interacting with and frequency of each interaction in relation with the number of poses.

![image3](https://github.com/ramirezlab/WIKI/blob/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/frequency_interactions_results.png)
