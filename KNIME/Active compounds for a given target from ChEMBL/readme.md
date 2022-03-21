# Welcome to the Ramirez Lab Wiki - Knime: Active compounds for a given target from ChEMBL #

This workflow use a local ChEBML database to search one or a list of targets and return information of compounds and activity reported to the input targets.

<p align="center">
    <img src="https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/media/ChEMBL_bioactive_compounds.png" width="1000">
</p>

## Requirements ##
- MySQL database service. [MySQL website and manual](https://dev.mysql.com/doc/refman/8.0/en/installing.html).
- Last ChEMBL MySQL database. [ChEBML databases](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/).
- Our *in-house* [Knime](https://www.knime.com/) workflow to connect to MySQL database and search for the compounds. [01_ChEMBL_bioactive_compunds](https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/01_ChEMBL_bioactive_compunds.knwf).
- A list of targets as UniprotIDs. [Download example set](https://github.com/ramirezlab/WIKI/raw/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/02_UniprotIDs.xlsx). 

To follow these instructions you must have already installed [Knime](https://www.knime.com/), [MySQL](https://dev.mysql.com/doc/refman/8.0/en/installing.html) and configured the lastest [ChEBML database](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/) on your local machine.

## 1. Conect ChEMBL local MySQL database with the workflow ##

First download and import our workflow [Active_compounds_for_a_given_target_from_ChEMBL workflow](https://github.com/ramirezlab/WIKI/raw/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/01_Active_compounds_for_a_given_target_from_ChEMBL.knwf) to Knime software. Then configure **MySQL Connector** node by right clicking at the node and click configure, and complete Hostname, Database name, username and Password based on your personal MySQL information.

<p align="center">
<img src="https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/media/mysql%20connector.png" width="500">
</p>

## 2. Set targets files and execute the workflow ##

To ensure that our workflow correctly recognice the list of target, the input file has to be a excel file (xlsx format), with a column named UniprotID that contains the list of targets as UniprotIDs.

To set the excel file as input you need to configure the **Excel Reader** node and modify the file path to your excel file and a preview will appear as below.
<p align="center">
<img src="https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/media/UniprotID_excel_file.png" width="700">
</p>

With these nodes already configured, run the workflow by click on the green "execute all executable nodes" buttom.

## 3. Results ##

In the same path of the Excel file used as input the workflow will generate 4 excel files:

- **1_compounds_bioactivity.xlsx**: Compounds with reported activities below 5 µM associated to the input list of targets. The interactions are separated on sheets by EC<sub>50</sub>, IC<sub>50</sub>, Ki and ALL all then.
- **2_multitarget_compounds_uM.xlsx**: Compounds that have reported interactions with 2 or more targets. The tables are also separated on sheets by EC<sub>50</sub>, IC<sub>50</sub>, Ki and pChEMBL_value.
- **3_all_targets_compounds_bioactivity.xlsx**: List of bioactivity reports including other targets that also have reported activities below 5 µM with the same compounds that the file "1_compounds_bioactivity.xlsx".
- **4_NOTFOUND_UniprotIDs.xlsx**: List of uniprotIDs that were not found on the ChEMBL DB.


