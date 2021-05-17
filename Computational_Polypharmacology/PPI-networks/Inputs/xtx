## *Welcome to the Ramirez Lab Wiki – MAPPING TARGETS AND DRUGS BY INDICATION*

<div align="justify">Here we used a KNIME workflow to capture relevant information about an indication of interest using different databases such as <a href="https://www.ebi.ac.uk/chembl" target="_blank"><b>CHEMBL</b></a></b>, <b><a href="http://db.idrblab.net/ttd/" target="_blank">TTD</a></b>, <b><a href="https://go.drugbank.com/" target="_blank"<b>DRUGBANK</b></a>, <b><a href="https://string-db.org/" target="_blank"<b>STRING</b></a> and <b><a href="https://www.opentargets.org/" target="_blank"<b>OPEN TARGETS</b></a>,  to obtain a complete list of targets, drugs and their phase of study, as well as the most important protein-protein interactions to characterize the modularity of the biological process associated with the disease. This workflow was standardized using Alzheimer's disease as an example.</div>

### Requirements

* Knime version 4.3.1 or higher, a programming software through functional workflow <b><a href="https://www.knime.com/" target="_blank">Knime website</a></b>

* Our internal Knime workflow to capture relevant information about an indication of interest using the different databases <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/End_Hunting-Targets_CP.knwf">**End_Hunting-Targets_CP**</a>.

* Download the input files to run the workflow <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/Inputs/Inputs.rar">**Inputs**</a>

* Output files using Alzheimer's disease as an example for the user to compare with the results obtained.

  <a href="https://github.com/jdhurtadop2017/Mapping_Targets/raw/master/Outputs/Outputs.rar"> **Outputs**</a>
  
  Here you can see a complete visualization of the workflow <a href="https://workflowigm.netlify.app/" target="_blank">**Workflow view**</a>
  
  
  
  ![](./media/Workflow.png)

###  1. Inputs - Acquisition of data from different databases to calculate interaction frequencies.

The following steps show how to proceed to load the entries:

* Indicate the path where the file 1_Drugs_TTD.txt (red box) is located on your computer, when running the workflow, the other input files will be loaded automatically as long as they are located in the same folder as file 1.

  <img src=".\media\input.png" style="zoom:50%;" />

* In the red box of the Select Disease node, interactively select the pathology of interest by right-clicking and selecting the Interactive View: single selection widget option.

  <img src=".\media\disease option.png" style="zoom:60%;" />

### 2. Enrichment of the small database of the indication of interest from other databases

* <div align="justify">The files coming from the different databases are processed to filter targets and drugs related to the indication of interest. In addition, targets are internally classified as T1, T2, and T3, according to the phase of study their drugs are in, such as:</div>

  T1: Approved or Phase 4

  T2: Clinical trials, phase 1, 2, or 3 or proprietary 

  T3: Investigational phase or completed or preclinical or phase 0

  <div align="justify">To complement the information on the pathology of interest, a query is made to the Open Targets database through the **EFO** (Experimental Factor Ontology), which serves as a disease identifier. Finally, a small database of the pathology of interest is obtained, enriched by the four databases, with the respective IDS, used by each database to identify targets and drugs. This small database can be accessed through output table 3. </div> 	

* <div align="justify">The node titled "T1/T2/T3 Classification" lists the targets classified as T1, T2, and T3 and their ID from Uniprot. The nodes and metanodes used in this workflow are properly documented internally to describe the process being performed.</div>

### 3. Protein protein interactions (PPI) using String

* <div align="justify">To integrate the protein-protein association network of targets classified as T1, T2, and T3, the STRING database was used, which aims to integrate all known and predicted protein-protein associations, including both physical interactions and functional associations. Targets interacting with T1 or T2 or T3 (neighbors), according to the STRING database, were referred to as T4 targets. T4 targets were filtered by querying the STRING database with the following parameters: </div>

  limit=20 and Required score= 400. 

  <div align="justify">This line indicates that to perform the query, the network of the 20 best targets that interact with the target of interest (either T1/T2/T3) and have an overall score ≥ 0.4 will be extracted (Overall score is the sum of all known, predicted and other interactions).</div> 

  <div align="justify">Subsequently, we filter out proteins with known interactions, from experimental data (escore) and curated databases (dscore), with a minimum score and with mean confidence of escore ≥0.4 or dscore ≥0.4. That is, we filter targets with an escore ≥0.4 or a dscore ≥0.4. The first and second interactor layers for the target of interest are taken into account. The first interactor layer is made up of the associations of the T1/T2/T3 targets and their direct neighbors referred to as T4 targets. </div>

  <div align="justify">The second layer of interactors formed by the direct associations of the T4 targets with other proteins different from the first layer, which we have also named T4.</div>

* T4 targets are filtered taking into account the targets reported by the Open targets database for the indication of interest. 

* <div align="justify">Normalization process: Based on the internal classification of the objectives (T1/T2/T3/T4), the  objectives were assigned a score as follows</div>

  T1=1.0

  T2=0.7 

  T3=0.4

  <div align="justify">T4=0.1The maximum value is 2.2 for objectives that are T1, T2, T3, and T4 and the minimum value is 0.1 for objectives that are only T4. Next, a normalization of the target score column was performed, taking the maximum value as 1.0 and the minimum value is 0.05 (Target Score Normalize).</div>
  
+ <div align="justify"> Protein-protein interactions (PPI): In this metanode we standardized the interactions between the targets (T1/T2/T3) with the T4 targets, so that there is only one connection, associated with a total score value coming from the STRING database since in some cases the connection was repeated in the opposite direction, but with the same score value, to eliminate this redundant information, we worked with the numerical values of the UniProt code of the T1/T2/T3/T4 targets and their score value</div>

### 4. Outputs- Results

<div align="justify">The output path was configured for the file 01_output-Target-Groups.xlsx, node framed in red, by default the other output files will be saved in the same path.</div>When I finish runningthis workflow, I get the following files in Excel format:

<img src=".\media\result1.png" style="zoom:60%;" />

* File 1: Detailed list of targets associated with an indication of interest along with their Uniprot ID, Target name classification (T1, T2, T3, or T4), target score, and normalized score.

  <img src=".\media\result 1.1.png" style="zoom:60%;" />

* <div align="justify">File 2: PPI information, in this case, the targets found in the UniprotID Prot_A column along with their interaction with the targets found in the UniprotID Prot_B column and the total STRING database score (showing the strength of that interaction), plus the names of the genes in the Prot_A and Prot_B columns.</div>

  <img src=".\media\result2.png" style="zoom:60%;" />

* <div align="justify">File 3: Presents a small database of targets and drugs for the indication of interest "Alzheimer's disease". The output path was set to file 01_output-Target-Groups.xlsx, node framed in red, by default the other output files will be saved in the same path.</div>

  <img src=".\media\result3.png" style="zoom:60%;" />

### 4. Citing

* Hurtado Pachon Jonathan; Peña Varas Carlos; Ramírez David. MAPPING TARGETS AND DRUGS BY INDICATION. Santiago, Chile; 2021.

  
