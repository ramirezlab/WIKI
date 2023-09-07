# Welcome to the Ramirez Lab Wiki - Knime: Disease related protein classification and PPI networks #

<p align="center">
    <img src="./media/Disease_related_protein_classification_and_PPI_networks_WF.png?raw=true" width="1000">
</p>

This Knime workflow uses multiple databases to search for disease related proteins by experimental reports or manual annotations, then proteins are classified by the development phase of their related drugs and assigned a score as follows:

- T1: Score 1.0, the target has approved compounds or phase 4 of development for indicated disease.
- T2: Score 0.7, the target has compounds under clinical trials or phases 1 to 3 of development for indicated disease.
- T3: Score 0.4, the target has compounds under preclinical investigations or phase 0 of development for indicated disease.
- T4: Score 0.1, the target has interactions with targets T1, T2 or T3.

**Note:** some targets can have multiple target classifications.

Finally the workflow provides protein-protein networks and lists of targets with their classifications for the indicated disease.  

## Requirements ##
**This workflow has been programed to be used on Linux OS only.**
- MySQL database service. [MySQL website and manual](https://dev.mysql.com/doc/refman/8.0/en/installing.html).
- Last ChEMBL MySQL database. [ChEBML databases](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/).
- "Target to disease mapping with ICD identifiers" and "Drug to disease mapping with ICD identifiers" files from TTD. [TTD full data downloads](http://db.idrblab.net/ttd/full-data-download). 
- Associated targets for a disease of choice on TSV format from Open Targets Platform. [Open Target Platform website](https://platform.opentargets.org/).
- Knime Analytics platform version 4.6.3 or higher. [Download Knime](https://www.knime.com/knime-analytics-platform).
- Our *in-house* [Knime](https://www.knime.com/) workflow [Disease_related_protein_classification_and_PPI_networks](./Disease_related_protein_classification_and_PPI_networks.knwf).


**To follow these instructions you must have already installed [Knime](https://www.knime.com/), [MySQL](https://dev.mysql.com/doc/refman/8.0/en/installing.html) and configured the lastest [ChEBML database](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/) on your machine.**

## Setting ChEMBL database with MySQL on Linux ##

Quick step by step MySQL installation. Form more information visit [MySQL website](https://dev.mysql.com/doc/refman/8.0/en/installing.html).

### MySQL installation: ### 
```
sudo apt update
sudo apt install mysql-server
```
### MySQL root password.  ###
log into MySQL database as sudo:
```
sudo mysql
```
set a password for root user:
```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
### Download ChEMBL database and load data to MySQL ###
Download the last release of  ChEMBL database of mysql (chembl_XX_mysql.tar.gz). **From now on, replace any XX for your downloaded ChEMBL database version.**
<p align="center">
<img src="./media/ChEMBLdb_download.png?raw=true" width="500">
</p>

Extract files:
```
tar -xvf chembl_XX_mysql.tar.gz
```
Log into MySQL and enter yout password:
```
mysql -u root -p
```
Create an empty database on MySQL:
```
mysql> create database chembl_XX DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

```
Logout of MySQL and run the following command to load data to the database (**this could take several hours**):
```
mysql -u root -p chembl_XX < chembl_XX_mysql.dmp
```

## 1. Connect ChEMBL local MySQL database with the workflow ##

First download and import our workflow [Disease_related_protein_classification_and_PPI_networks](./Disease_related_protein_classification_and_PPI_networks.knwf) to Knime software. Then configure **MySQL Connector** node by right clicking at the node and click configure option. Complete the fields with your Hostname, Database name, username and Password based on your personal MySQL information.

<p align="center">
<img src="./media/MySQL_Connector.png?raw=true" width="500">
</p>

## 2. Select input files from TTD and Open Targets Platform ##

Download the files "Target to disease mapping with ICD identifiers" and "Drug to disease mapping with ICD identifiers" files from [TTD](http://db.idrblab.net/ttd/full-data-download).

<p align="center">
<img src="./media/TTD_website.png?raw=true" width="500">
</p>

Configure the "Therapeutic Target Database" node by browsing the files. Taget file first and Drugs file second.

<p align="center">
<img src="./media/Therapeutic_Target_Database.png?raw=true" width="500">
</p>

On Open Targets Platform search for any Disease and download the Associated Targets file on TSV format.

<p align="center">
<img src="./media/Open_Targets_Platform_website.png?raw=true" width="500">
</p>

Configure "Open Targets Platform" node by browsing the file.

<p align="center">
<img src="./media/Open_Targets_Platform.png?raw=true" width="500">
</p>


## 3. Disease selection ##

Frist execute "Disease list" node to read all available diseases on ChEMBL database.

<p align="center">
<img src="./media/Disease_list_node.png?raw=true" width="100">
</p>

Then configure and select one disease from the list on "Disease selector" node. If no list is displayed on "Disease selector" configuration reset and execute "Disease list" again, and try to configure "Disease selector" again.

<p align="center">
<img src="./media/Disease_selector.png?raw=true" width="500">
</p>

## 4. Choose a folder to write the results and execute the workflow ##

Configure "Folder to write results" node by browsing to a folder to write result files. Make sure to select a folder and not a file.

<p align="center">
<img src="./media/Results_folder.png?raw=true" width="500">
</p>

Finaly execute the rest of the workflow by clicking on "Execute all executable nodes" buttom or press (SHIFT+F7).

## 5. Results ##

### [1_PPI_network_Alzheimer_no-opentarget-filter.csv](./sample_outputs/1_PPI-network_Alzheimer_Disease_no-opentarget-filter.csv) ###
 Has protein-protein interactions, as Prot_A and Prot_B columns with the protein genes, uniprot ID for each protein, interaction score and Disease. If the target is a protein complex, the gene name is replaced by ChEMBL ID of the complex, and the uniprot ID will be a list of uniprot IDs.
 
| Prot_A | Prot_B | score | Disease             |
|--------|--------|-------|---------------------|
| GNB3   | HTR7   | 0.932 | Alzheimer's Disease |
| GNB3   | GNAS   | 0.982 | Alzheimer's Disease |
| GNB3   | GNG3   | 0.998 | Alzheimer's Disease |
| GNB3   | GNG5   | 0.998 | Alzheimer's Disease |
| GNB3   | GNG11  | 0.998 | Alzheimer's Disease |
| GNB3   | GNG12  | 0.998 | Alzheimer's Disease |
| GNB3   | GNG10  | 0.998 | Alzheimer's Disease |
| GNB3   | GNGT1  | 0.999 | Alzheimer's Disease |
| GNB3   | GNG13  | 0.999 | Alzheimer's Disease |
### [2_PPI_network_Alzheimer_opentarget-filter.csv](./sample_outputs/2_PPI_network_Alzheimer_opentarget-filter.csv) ###
Same as the previous file, but including only targets found on Open Targets Platform.

### [3_Targets_score_Alzheimer_no-opentarget-filter.xlsx](./sample_outputs/3_Targets_score_Alzheimer_no-opentarget-filter.xlsx) ###
List of single proteins related to the disease, sorted by target score.

| target_name                                                | target | uniprotID  | target_type    | target_group | source_db   | target_group_score | target_group_score_normalized | Disease             |
|------------------------------------------------------------|--------|------------|----------------|--------------|-------------|--------------------|-------------------------------|---------------------|
| Acetylcholinesterase                                       | ACHE   | P22303     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL, TTD | 2.1                | 1                             | Alzheimer's Disease |
| Beta amyloid A4 protein                                    | APP    | E9PG40     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL, TTD | 2.1                | 1                             | Alzheimer's Disease |
| Chromobox protein homolog 1                                | CBX1   | P83916     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL      | 2.1                | 1                             | Alzheimer's Disease |
| Dopamine D2 receptor                                       | DRD2   | P14416     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL, TTD | 2.1                | 1                             | Alzheimer's Disease |
| Histone-lysine N-methyltransferase, H3 lysine-9 specific 3 | EHMT2  | Q96KQ7     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL      | 2.1                | 1                             | Alzheimer's Disease |
| Geminin                                                    | GMNN   | E2QRF9     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL      | 2.1                | 1                             | Alzheimer's Disease |
| Glutamate NMDA receptor; GRIN1/GRIN2B                      | GRIN1  | Q5VSF9     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL, TTD | 2.1                | 1                             | Alzheimer's Disease |
| Glutamate NMDA receptor; GRIN1/GRIN2A                      | GRIN2A | A0A6Q8PGD2 | SINGLE PROTEIN | T1, T2, T3   | ChEMBL, TTD | 2.1                | 1                             | Alzheimer's Disease |
| Prelamin-A/C                                               | LMNA   | P02545     | SINGLE PROTEIN | T1, T2, T3   | ChEMBL      | 2.1                | 1                             | Alzheimer's Disease |
### [4_Targets_score_Alzheimer_opentarget-filter.xlsx](./sample_outputs/4_Targets_score_Alzheimer_opentarget-filter.xlsx) ###
Same as the previous file, but including only targets found on Open Targets Platform.

### 6. Network visualization ###
The network can be visualized with Cytoscape and the attributes can be added by loading [3_PPI-network_targets_attributes_Alzheimer](./sample_outputs/3_PPI-network_targets_attributes_Alzheimer.csv) file to the network nodes.

<p align="center">
<img src="./media/2_PPI_network_AD.png?raw=true" width="800">
</p>
