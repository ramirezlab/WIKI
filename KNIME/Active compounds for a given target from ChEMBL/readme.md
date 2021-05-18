# Welcome to the Ramirez Lab Wiki - Knime: Active compounds for a given target from ChEMBL #

This workflow use a local ChEBML database to search one or a list of targets and return information of compounds and activity reported to the input targets.

<p align="center">
    <img src="https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/media/WF.png" width="1000">
</p>

## Requirements ##
- MySQL database service.[MySQL website](https://dev.mysql.com/doc/refman/8.0/en/installing.html).
- Last ChEMBL MySQL database. [ChEBML databases](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest/).
- Our *in-house* Knime workflow to connect to MySQL database and search for the compounds.[Active_compounds_for_a_given_target_from_ChEMBL workflow](https://github.com/ramirezlab/WIKI/raw/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/01_Active_compounds_for_a_given_target_from_ChEMBL.knwf).
- A list of targets as UniprotIDs. [Download example set](https://github.com/ramirezlab/WIKI/raw/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/02_UniprotIDs.xlsx). 




## 1. Conect ChEMBL MySQL database with the workflow ##
<img src="https://github.com/ramirezlab/WIKI/blob/master/KNIME/Active%20compounds%20for%20a%20given%20target%20from%20ChEMBL/media/mysql%20connector.png" width="500">









## 2. Configure the list of targets ##

## 3. Results ##



