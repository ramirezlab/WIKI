# Welcome to the Ramirez Lab Wiki - Knime: Disease related protein classification and PPI networks #

<p align="center">
    <img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Disease_related_protein_classification_and_PPI_networks_WF.png?raw=true" width="1000">
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
- Our *in-house* [Knime](https://www.knime.com/) workflow [Disease_related_protein_classification_and_PPI_networks](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/raw/main/Disease_related_protein_classification_and_PPI_networks.knwf).


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
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/ChEMBLdb_download.png?raw=true" width="500">
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

First download and import our workflow [Disease_related_protein_classification_and_PPI_networks](https://github.com/ramirezlab/WIKI/raw/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/01_Active_compounds_for_a_given_target_from_ChEMBL.knwf) to Knime software. Then configure **MySQL Connector** node by right clicking at the node and click configure option. Complete the fields with your Hostname, Database name, username and Password based on your personal MySQL information.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/MySQL_Connector.png?raw=true" width="500">
</p>

## 2. Select input files from TTD and Open Targets Platform ##

Download the files "Target to disease mapping with ICD identifiers" and "Drug to disease mapping with ICD identifiers" files from [TTD](http://db.idrblab.net/ttd/full-data-download).

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/TTD_website.png?raw=true" width="500">
</p>

Configure the "Therapeutic Target Database" node by browsing the files. Taget file first and Drugs file second.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Therapeutic_Target_Database.png?raw=true" width="500">
</p>

On Open Targets Platform search for any Disease and download the Associated Targets file on TSV format.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Open_Targets_Platform_website.png?raw=true" width="500">
</p>

Configure "Open Targets Platform" node by browsing the file.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Open_Targets_Platform.png?raw=true" width="500">
</p>


## 3. Disease selection ##

Frist execute "Disease list" node to read all available diseases on ChEMBL database.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Disease_list_node.png?raw=true" width="100">
</p>

Then configure and select one disease from the list on "Disease selector" node. If no list is displayed on "Disease selector" configuration reset and execute "Disease list" again, and try to configure "Disease selector" again.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Disease_selector.png?raw=true" width="500">
</p>

## 4. Choose a folder to write the results and execute the workflow ##

Configure "Folder to write results" node by browsing to a folder to write result files. Make sure to select a folder and not a file.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/Results_folder.png?raw=true" width="500">
</p>

Finaly execute the rest of the workflow by clicking on "Execute all executable nodes" buttom or press (SHIFT+F7).

## 5. Results ##

### [1_PPI_network_Alzheimer's disease_no-opentarget-filter.csv](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/raw/main/sample_outputs/1_PPI_network_Alzheimer's%20disease_no-opentarget-filter.csv) ###
 Has protein-protein interactions, as Prot_A and Prot_B columns with the protein genes, uniprot ID for each protein and Disease. If the target is a protein complex, the gene name is replaced by ChEMBL ID of the complex, and the uniprot ID will be a list of uniprot IDs.
 
| Prot_A        | Prot_B        | uniprotID_Prot_A            | uniprotID_Prot_B            | Disease             |
|---------------|---------------|-----------------------------|-----------------------------|---------------------|
| GNB3          | GNB2          | P16520                      | P62879                      | Alzheimer's disease |
| GNB3          | CHEMBL3883319 | P16520                      | P62873 P59768               | Alzheimer's disease |
| GNB3          | GNB1          | P16520                      | P62873                      | Alzheimer's disease |
| GNB3          | GNB4          | P16520                      | Q9HAV0                      | Alzheimer's disease |
| GNB3          | GNB5          | P16520                      | O14775                      | Alzheimer's disease |
| GNB3          | HTR7          | P16520                      | P34969                      | Alzheimer's disease |
| GNB3          | GNAL          | P16520                      | P38405                      | Alzheimer's disease |
| GNB3          | GNAS          | P16520                      | P63092                      | Alzheimer's disease |
| GNB4          | CHEMBL3883319 | Q9HAV0                      | P62873 P59768               | Alzheimer's disease |
| GNB4          | GNB1          | Q9HAV0                      | P62873                      | Alzheimer's disease |

### [2_PPI_network_Alzheimer's disease_opentarget-filter.csv](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/raw/main/sample_outputs/2_PPI_network_Alzheimer's%20disease_opentarget-filter.csv) ###
Same as the previous file, but including only targets found on Open Targets Platform.

### [3_PPI-network_targets_attributes_Alzheimer's disease](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/sample_outputs/3_PPI-network_targets_attributes_Alzheimer's%20disease.csv) ###
List of single targets (including protein complexes) with attributes to add custom styles on Cytoscape.

| gene_name     | target_type     | target_group | target_group_score_normalized | Disease             |
|---------------|-----------------|--------------|-------------------------------|---------------------|
| ACHE          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| APP           | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| CBX1          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| DRD2          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| EHMT2         | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| GMNN          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| LMNA          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| PPARG         | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| SLC6A4        | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| SLCO1B1       | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| TDP1          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| USP1          | SINGLE PROTEIN  | T1 T2 T3 T4  | 1                             | Alzheimer's disease |
| BCHE          | SINGLE PROTEIN  | T1 T2 T4     | 0.8285714285714285            | Alzheimer's disease |
| CHRNE         | SINGLE PROTEIN  | T1 T2 T4     | 0.8285714285714285            | Alzheimer's disease |

### [4_Targets_score_Alzheimer's disease_no-opentarget-filter.xlsx](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/raw/main/sample_outputs/3_Targets_score_Alzheimer's%20disease_no-opentarget-filter.xlsx) ###
List of single proteins related to the disease, sorted by target score.

| gene_name | target_type    | uniprotID | target_group   | source_db           | target_group_score | target_group_score_normalized | chembl_id_SplitResultList | Disease             |
|-----------|----------------|-----------|----------------|---------------------|--------------------|-------------------------------|---------------------------|---------------------|
| ACHE      | SINGLE PROTEIN | P22303    | T1, T2, T3, T4 | ChEMBL, STRING, TTD | 2,2                | 1                             | CHEMBL220                 | Alzheimer's disease |
| APP       | SINGLE PROTEIN | P05067    | T1, T2, T3, T4 | ChEMBL, STRING, TTD | 2,2                | 1                             | CHEMBL2487                | Alzheimer's disease |
| CBX1      | SINGLE PROTEIN | P83916    | T1, T2, T3, T4 | ChEMBL, STRING      | 2,2                | 1                             | CHEMBL1741193             | Alzheimer's disease |
| DRD2      | SINGLE PROTEIN | P14416    | T1, T2, T3, T4 | ChEMBL, STRING, TTD | 2,2                | 1                             | CHEMBL217                 | Alzheimer's disease |
| EHMT2     | SINGLE PROTEIN | Q96KQ7    | T1, T2, T3, T4 | ChEMBL, STRING      | 2,2                | 1                             | CHEMBL6032                | Alzheimer's disease |
| GMNN      | SINGLE PROTEIN | O75496    | T1, T2, T3, T4 | ChEMBL, STRING      | 2,2                | 1                             | CHEMBL1293278             | Alzheimer's disease |
| LMNA      | SINGLE PROTEIN | P02545    | T1, T2, T3, T4 | ChEMBL, STRING      | 2,2                | 1                             | CHEMBL1293235             | Alzheimer's disease |
| PPARG     | SINGLE PROTEIN | P37231    | T1, T2, T3, T4 | ChEMBL, STRING, TTD | 2,2                | 1                             | CHEMBL235                 | Alzheimer's disease |
| SLC6A4    | SINGLE PROTEIN | P31645    | T1, T2, T3, T4 | ChEMBL, STRING, TTD | 2,2                | 1                             | CHEMBL228                 | Alzheimer's disease |
| SLCO1B1   | SINGLE PROTEIN | Q9Y6L6    | T1, T2, T3, T4 | ChEMBL, STRING      | 2,2                | 1                             | CHEMBL1697668             | Alzheimer's disease |

### [5_Targets_score__Alzheimer's disease_opentarget-filter.xlsx](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/raw/main/sample_outputs/5_Targets_score_Alzheimer's%20disease_opentarget-filter.xlsx) ###
Same as the previous file, but including only targets found on Open Targets Platform.

### 6. Network visualization ###
The network can be visualized with Cytoscape and the attributes can be added by loading [3_PPI-network_targets_attributes_Alzheimer's disease](https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/sample_outputs/3_PPI-network_targets_attributes_Alzheimer's%20disease.csv) file to the network nodes.

<p align="center">
<img src="https://github.com/AlePV/Disease_related_protein_classification_and_PPI_networks/blob/main/media/2_PPI_network_AD.png?raw=true" width="500">
</p>
