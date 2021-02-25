# Welcome to the Ramirez Lab Wiki - Docking post-processing: Clustering and interactions analysis #
<!-- como tambien usamos este workflow para analizar las dinamicas de la tubulina creo que deberiamos cambiar el titulo de este proceso -->

To analyze the frequency of interactions between ligand and receptor on a set of poses we use scripts included on Schrödinger suit 2020 and in-house functional workflow built on Knime.
## 1. Requirements ##
- Schrödinger suit 2020 or newer (full or academic Desmond version). 2020 poseviewer script include more interaction types that older versions. [Academic Desmond version](https://www.deshawresearch.com/downloads/download_desmond.cgi/).
-Knime, a programing software via functional work flows. [Knime website](https://www.knime.com/).
- A set of receptor complex-ligand conformations, could be a poses obtained from molecular dynamics simulations or different poses that belong to a cluster. To test this pipe-line we provide a example cluster with all files split and interactions calculated on csv files. [Example cluster set](https://github.com/ramirezlab/WIKI/tree/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/ligand-receptor_complex_example_set).

## 2. Split receptor-ligand complex into separate files ##

To make sure that receptor and ligand are being use as input con step in correct order we split the receptor-ligand complex in two separate files using *split_structure.py* script of Schrödinger. This can be done to all complex within a folder writing and executing the following bash script:

***split.awk***
````
echo "Processing data ..."

for f in *.maegz; do
    $SCHRODINGER/run split_structure.py ${f} -m ligand -k -many_files ${f%.maegz}.mae    
done

echo "Done!!"
````

Execute on a terminal with:
````
$ ./split.awk
````
For more information about the script options you can write in the terminal:
````
$ $SCHRODINGER/run split_structure.py -h
````
## 3. Calculate interactions between ligand and receptor ##

To calculate the interaction between receptor and ligand we use *poseviewer_interactions.py* script of Schrödinger suit 2020. When setting  inputs make sure to give first the receptor and then the ligand file, followed by "-csv" to also export the results on a csv format file. You can calculate the interactions on all the previously split files by writing the next script:

***poseviewer.awk***  
````
echo "Processing data ..."

for f in *_receptor1.mae; do
$SCHRODINGER/run poseviewer_interactions.py ${f} ${f%_receptor1.mae}_ligand1.mae -csv  
done

echo "Done!!"
````

Execute on a terminal with:
````
$ ./poseviewer.awk
````
For more information about the script options you can write in the terminal:

````
$ $SCHRODINGER/run poseviewer_interactions.py -h
````
## 4. Calculate interaction frequencies for user defined ligand fragments ##
To calculate the frequency of interactions in function on the number of poses of the set we built a Knime workflow. The user have to configure 3 nodes:
- **List Files/Folders:** The user have to set a folder with all csv files with the interactions calculated on the step 3.
- **Table Creator:** The user need to list all ligand atoms on the first column and to which fragment it belongs.
- **Excel Writer:**  Finally the user has to configure a path to where save the file as an Excel data sheet.

<!-- subir imagen del workflow -->

## 5. Results ##
The results table shows ligand framents, which resudue is interacting with and frequency of each interaction in relation with the number of poses.


<!-- subir imagen de resultados-->
