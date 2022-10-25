# Search for pharmacophores based on bioactive molecules in key proteins for Alzheimer's disease

Using a workflow implemented with the [Knime](https://www-knime-com.translate.goog/?_x_tr_sl=auto&_x_tr_tl=es&_x_tr_hl=es-419)
 tool (open source software used in data science) and bash code, we started with a dataset of key proteins associated with AD, for each of them we identified the bioactive molecules (EC50, IC50, Ki and pChEMBL) from the database [ChEMBL](https://www.ebi.ac.uk/chembl/). Each set of molecules were filtered according to Lipinski's rules and a similarity matrix was calculated using the Morgan fingerprint and Tanimoto similarity coefficient. Subsequently, they were classified by hierarchical clustering, thus finding clusters of bioactive molecules against each target, but different from each other. Finally, for each cluster, pharmacophore hypotheses were generated with Phase software, selecting the best one with respect to the phasehyposcore, resulting in a set of pharmacophores.

## Requirements
- Knime version 4.6, open source software for data analysis.
- Unix operating system to run scripts (ubuntu 22.04 was used)
- Install rename to run script 2 and 3 in bash "sudo apt install rename", if using conda "conda install -c bioconda rename".
 
This workflow is composed of 2 parts, the first corresponds to a flow with Knime that is subdivided into 4 steps, which can be seen in the figure and the second part corresponds to 3 codes implemented with bash. 

 ![Workflow KNIME](/media/fig1.png)

 
  #### 1. Input file
The input file is in csv format and presents a dataset with active molecules and in this case its characteristics include: inhibition constant (ec50, ic50 and Ki), id_CHEMBL, standard inchi/inchi-key and SMILES. (It can also have as inhibition constant pChEMBL which corresponds to -log in base 10 of the ec50, ic50 or ki constants).

 ![CSV-knime](/media/fig_2.png) 

In addition they are separated by each type of inhibition that they present as already mentioned EC50, IC50, Ki and pChEMBL.

 <img src="/media/fig3.png" width="450" height="450">
  
#### 2. Molecular filtering: ADME and lead-likness criteria

The next step is a molecular filtering applying the Lipinski rule of 5 (LogP <=5, molecular weight <=500 gr/mol, hydrogen bond acceptors <= 10 and hydrogen bond donors <=5). In this case, molecular weight <=600 gr/mol is considered and these characteristics are calculated for each of the molecules and the compounds that respect 3 or 4 of the characteristics corresponding to molecular properties that have pharmacokinetic importance in the human body are selected.

##### Step 1: Calculate MW, HBD, HBA, and LogP
With the canonical format obtained from RDKit, the salts that may be present in the molecules are removed and the properties of the Lipinski rules are calculated.

##### Step 2:Filter dataset by Lipinski's rule of five
With the properties obtained from the previous step for each of the molecules, a filter is applied for each property (MW, HBD, HBA, LogP) and a Boolean value is assigned (1 meets and 0 does not meet), then these values are summed for each molecule and all molecules with a value of 3 or 4 of the pharmacokinetic characteristics evaluated are selected.

For example, the figure shows that the SlogP of the molecule exceeds the allowed range (<=5), so a boolean=0 is assigned.
 ![Boolean_ROF](/media/fig15.png)
   
#### 3. Get compound clustering
To generate the clusters, we used the identification of groups by similar molecules based on the Morgan fingerprint and the calculation of the Tanimoto distance, and by means of the hierarchical clustering algorithm we selected the most significant clusters with 10 or more molecules.

##### Step 3: Cluster dataset with hierarchical clustering algorithm
The molecules are grouped according to the chemical structural similarity between them and thus find groups that share a common scaffold. These molecules are identified with fingerprints in this case was carried out by Morgan FingerPrint and in the case of similarity can be described by the Tanimoto coefficient, which varies from zero to one, where values close to zero represent a low similarity and values close to 1 a high similarity.

 ![fingerprint-tanimoto](/media/fig_4.png)
 Through the hierarchical clustering assigner node, the values obtained by the assigned threshold can be observed.
 
![nodo_graph](/media/fig16.png)

The graph shows that with a threshold of 0.6, 146 clusters are generated, which are subsequently classified as non-significant and significant, and the significant ones must have 10 or more molecules in their group.
![dendogram_clusters](/media/fig_5.png)

##### Step 4: Get significant cluster 
Through the sorter node, the clusters are ordered from highest to lowest and then with the Bar Chart node, the populations can be observed for each node generated.

<img src="/media/fig17.png" width="500" height="600">

The bar chart shows the population of molecules that make up each of the clusters formed for this group. 
![barchar_clusters](/media/fig_6.png)

A file called "all_clusters.xlsx" is generated with the result of the significant and non-significant clusters for each type of inhibition.
<img src="/media/fig9.png" width="600" height="700">

By means of the Scatter Plot node, the results for each Lipinski rule (ROF) can be observed interactively (graphs). In addition, the figure shows a series of options where you can define the characteristics that you want to plot in X and Y, as well as add title and subtitles.
![graph_rof](/media/fig18.png)

The Lipinski rules for each cluster can also be seen in the graphs. For example in the first of them SlogP these values must be less than or equal to 5, but since it is allowed to violate a rule these values can be higher and it is observed in the graph that there are values that reach up to 7.5, followed by the molecular weight, although it must be less than or equal to 500 grams/mol, it was established in this case that it must be less than or equal to 600 grams/mol and finally the number of hydrogen bond donors and acceptors must be less than or equal to 5 and 10, observing that the rules are complied with and the molecules are grouped in these values.
![rof_clusters](/media/fig7.png)
![rof_clusters](/media/fig8.png)
   
#### 4. Get and download compound clustering in SDF and crystal PDB
In the last step the molecule pathway is obtained and the group of molecules is downloaded in SDF format and in the case that this molecule is present in a PDB crystal this crystal will be downloaded. In addition, an xlsx output file is generated with the information of the molecule present in each pdb crystal.

##### Step 5: Get and download compound and crystal pdb and information file
The path of the molecule is obtained by means of the id ChEMBL, in the case that this path is not found it is searched by the and the standard inchi key. After obtaining the path of the molecule, you can know if the molecule is co-crystallized with a protein and download the PDB file and in turn download each cluster with their respective molecules in SDF format.


As a final result, a folder is obtained for each protein (each input file) and in each folder there are 4 different types of files as shown in the figure below.
![end_result](/media/fig10.png)


#### 5. Scripts in bash
Using 3 bash scripts, the results obtained from the knime workflow are taken and the first script is in charge of transforming the files from SDF to MAE format and then preparing the molecules at a given pH. The second script is in charge of creating the pharmacophores for each of the files and the third script is in charge of selecting the best pharmacophore hypothesis for each cluster. 

The following figure shows that the scripts to be used must be found in a folder behind where all the results are located. In addition, there are 2 files (file.inp and file.def) that will be used for the creation of pharmacophores.
![file_pre_script](/media/fig11.png)

To run the scripts you must do so in consecutive order after each one has finished. And the way to run them is as follows:
- ./1_preparate_ligprep.sh
- ./2_create_pharmacophore.sh
- ./3_search_hypotheses.sh


##### Script 1: 1_preparate_ligprep.sh
In the folder file to create pharmacophore there are 2 files with extension inp and def which you must copy and leave in the same path where the scripts are located, since they will be used in the first script to make the pharmacophore input.
The script has 3 functions, which are:

- Change the format of the sdf files to mae, and prepare the molecules with Schrodinger's LigPrep at pH 7.4 +/-0.2 and generating at most one ligand.

 - Separate the files into different folders according to the corresponding extension of each one (01_cluster_mae, 01_cluster_prep, 01_ligprep, 01_pdb, 01_sdf), and also generate two more folders that will be used in the following scripts, 02_pharmacophore (script 2) and 03_hypothesis (script 3).

- Copy and rename the inp and def files with the name corresponding to their directory and cluster, since they are used as input for the elaboration of the pharmacophores.
![script_1](/media/fig12.png)


##### Script 2: 2_create_pharmacophore.sh
The script has 2 functions, which are:
 
- In the 01_cluster_prep folder the pharmacophore hypotheses are generated using the inp and def files for each cluster considering 3 to 7 features for the hypotheses and generating at most 10 hypotheses for each of these features and finally with an 85% match. The files with extension phprj and phypo.mae.gz are moved to the pharmacophore folder.
 
 - From the phypo.mae.gz file generated from the previous function, 2 columns are extracted corresponding to the name of the hypothesis and its phasehyposcore which is the score assigned to the hypothesis, this file is sorted with respect to the score from highest to lowest score and saved in csv format the first hypothesis in the list that is with the highest score is considered the best of the cluster.
![script_2](/media/fig13.png)

   


##### Script 3: 3_seach_hypotheses.sh
The script has 3 functions, which are: 

- It is located in the pharmacophore folder and with respect to the generated csv file it saves the name of the hypothesis that has the best score and searches for the hypothesis in the folder .phprj/hypotheses, when it finds it it renames it with respect to FolderName_Cluster_Cluster_HypothesisFeatures and moves it to the folder 03_Hypotheses_FolderName where all the best hypotheses of each cluster for the protein under study will be.
![script_3](/media/fig14.png)

Finally in the following figure you can see some of the pharmacophore hypotheses obtained at the end of the script 3.
![hypotheses](/media/fig19.png)


If you want to check your results, they can be found in the 02_Results folder of the following link https://drive.google.com/drive/folders/1m4e-7gfALMZ-5eSXHzNM1rwCol9flBeH?usp=sharing.
