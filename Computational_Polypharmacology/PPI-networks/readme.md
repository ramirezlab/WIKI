# Welcome to the Ramirez Lab Wiki – Protein-protein interactions networks (PPI) for key targets in a given disease

<div align="justify">Here we present a KNIME workflow which can be used to capture relevant information from an indication of interest relying in different databases such as <a href="https://www.ebi.ac.uk/chembl" target="_blank"><b>CHEMBL</b></a></b>, <b><a href="http://db.idrblab.net/ttd/" target="_blank">TTD</a></b>, <b><a href="https://go.drugbank.com/" target="_blank"<b>DRUGBANK</b></a>, <b><a href="https://string-db.org/" target="_blank"<b>STRING</b></a> and <b><a href="https://www.opentargets.org/" target="_blank"<b>OPEN TARGETS</b></a>,  to obtain a complete list of protein targets, drug names and their respective study phase, as well as key protein-protein interactions related to these targets in order to achieve a biological characterization of the processes associated with a selected disease. This workflow was standardized using Alzheimer's disease as an example.</div>

### Requirements

* Knime version 4.3.1 or higher, a programming software through functional workflow <b><a href="https://www.knime.com/" target="_blank">Knime website</a></b>

* Our Knime workflow to capture relevant information about an indication of interest using different databases <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/PPI-network.knwf">**PPI-network**</a>.

* Input files to run the workflow <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/Inputs/Inputs.rar">**Inputs**</a>

* Output files obtained using Alzheimer's disease as an example for the user to compare results  <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/Outputs/Outputs.rar"> **Outputs**</a>
  
  Here you can have a complete visualization of the workflow <a href="https://workflowigm.netlify.app/" target="_blank">**Workflow Visualization**</a>
  
  
  
  ![](./media/Workflow.png)

###  1. Input - Data acquisition from databases for interaction frequencies calculation.

The following steps describe how to load entries:

* Indicate the path where the file 1_Drugs_TTD.txt (red box) is located on your computer, once the workflow starts running the other input files will be loaded automatically as long as they are located in the same folder as file 1.

  <img src=".\media\input.png" style="zoom:50%;" />

* Left-clicking the node named Select Disease select the pathology of interest as well as the Interactive View: single selection widget option.

  <img src=".\media\disease option.png" style="zoom:55%;" />

### 2. Data enrichment from various databases

* <div align="justify"> Data obtained from different databases is processed in order to filter target proteins and drugs which have been found associated with the indication of interest. In addition, targets are classified according to their related drugs study phase as T1, T2, and T3, meaning:</div>

  T1: Approved drug or Phase 4

  T2: Clinical trials, phase 1, 2, or 3 or proprietary 

  T3: Investigational phase, completed, preclinical or phase 0

  <div align="justify">Looking to complement the information of the pathology of interest, a query in Open Targets database is made through the **EFO** (Experimental Factor Ontology), which serves as a disease identifier. Finally, a small, filtered, database of the pathology of interest is obtained, enriched with information from four databases, through the respective IDs of proteins targets and associated drugs. This small database generates the Output Table 3. </div> 	

* <div align="justify">The node titled "T1/T2/T3 Classification" lists the targets classified as T1, T2, and T3 as well as their respective Uniprot ID. The nodes and metanodes used in this workflow are properly documented inside the workflow to describe the processes to be performed.</div>

### 3. Protein-Protein Interactions (PPI) query using STRING database

* <div align="justify">To integrate the PPI network constructed considering the targets classified as T1, T2, and T3, the STRING database is used. This node integrates all known and predicted PPI, including both physical interactions and functional associations. Those proteins which are found by the STRING database interacting with T1, T2 or T3 proteins (neighbours), are classified as T4 protein targets. T4 targets are filtered running a query in STRING database with the following parameters: </div>

  Limit = 20, and Required score = 400. 

  <div align="justify">This line indicates that in order to perform the query, the 20 best targets which interact with the target of interest (either T1/T2/T3) and have an overall score ≥ 0.4 will be extracted to build the PPI network (Overall score is the sum of all known, predicted and other interactions).</div> 

  <div align="justify">Subsequently, proteins with known interactions are filtered, from experimental data (eScore) and curated databases (dScore), with a minimum score, a mean confidence eScore ≥0.4 or dScore ≥0.4. According to these parameters, targets with an eScore ≥0.4 or a dScore ≥0.4 are filtered. The first and second interactor layers for the target of interest are taken into account. The first interactor layer is made up from the T1/T2/T3 targets interactions, as well as their direct neighbours classified as T4 targets. </div>

  <div align="justify">The second layer of interactors is formed by the direct associations of T4 targets with proteins different from those in the first layer, these proteins will be also classified as T4.</div>

* T4 targets are filtered considering the protein targets reported in Open Targets database for the indication of interest. 

* <div align="justify">Normalization process: based on the internal classification of the obtained protein targets (T1/T2/T3/T4), each target category had assigned a score as follows:</div>

  T1 = 1.0

  T2 = 0.7 

  T3 = 0.4
  
  T4 = 0.1

  <div align="justify">Thus, the maximum possible value for a target is 2.2, which are proteins classified in the categories T1, T2, T3, and T4. The minimum value is 0.1, for targets which only fall in the T4 classification. Following this score assignation, a normalization of the Target Score column is performed, considering 1.0  as the maximum value, 0.05 as the minimum value (Target Score Normalized).</div>
  
+ <div align="justify"> Protein-Protein Interactions (PPI): In this metanode interactions between the targets (T1/T2/T3) with the T4 targets are standarized, so that there is only one connection between a pair of proteins. This normalization is associated with the Total Score value obtained from STRING database. This is a key step since, in some cases, a PPI is duplicated with two opposite directions, with the same score value. In order to eliminate this redundant information, we worked with the numerical values of the UniProt ID of the T1/T2/T3/T4 targets and their respective Total Score.</div>

### 4. Outputs and Results

<div align="justify">The output path was configured to save a .xlsx file named 01_output-Target-Groups.xlsx, by default the other output files will be saved in the same path.</div>When this workflow ends running, the following files are obtained as a result:

<img src=".\media\result1.png" style="zoom:20%;" />

* File 1: Detailed list of targets associated with the indication of interest along with their respective Uniprot ID, Target Group classification (T1, T2, T3, or T4), Target Score, and Normalized Score.

  <img src=".\media\result 1.1.png" style="zoom:60%;" />

* <div align="justify">File 2: PPI table, in this case, the targets are found in the UniprotID Prot_A column, and their interacting target is found in the UniprotID Prot_B column, a third column named total STRING database score, quantifies the strength of that interaction. Finally, the gene names associated with the UniProt IDs are found in the Prot_A and Prot_B columns.</div>

  <img src=".\media\result2.png" style="zoom:50%;" />

* <div align="justify">File 3: Presents a small database of protein targets and drugs for the indication of interest, in this case for Alzheimer's disease. The output path was set to save a file named 01_output-Target-Groups.xlsx, by default the other output files will be saved in the same path.</div>

  <img src=".\media\result3.png" style="zoom:50%;" />

### 4. Citation

* Hurtado-Pachon, Jonathan; Peña-Varas, Carlos; Ramírez, David. Protein-protein interactions networks (PPI) for key targets in a given disease. Santiago, Chile; 2021.

  
