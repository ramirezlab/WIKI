# Welcome to the Ramirez Lab Wiki - RMSD Calculation

The Root Mean Square Deviation (RMSD) is a common metric used to evaluate the distance between the predicted pose and the native pose, given a superposition of proteins or ligands. It is calculated with the following equation:

<p align="center">
  <img src="https://github.com/Claudia-Alejandra-Martinez/Calculate-RMSD/blob/main/Calculate%20RMSD/media/RMSD.PNG?raw=true">
 </p>

Equation taken from: [J. Cheminform 11, 40 (2019)](https://doi.org/10.1186/s13321-019-0362-7)


where N is the number of atoms in the ligand, and di is the Euclidean distance between the two atoms in the i-th pair of corresponding atoms.

You will need: Schrödinger

1. Calculate the RMSD of a single ligand:

- Use the [rmsd.py](https://www.schrodinger.com/sites/default/files/s3/mkt/Documentation/current/docs/Documentation.htm#program_utility_usage/rmsd.html?TocPath=Command%2520References%257CProgram%252C%2520Script%252C%2520and%2520Utility%2520Usage%257C_____353) script to calculate the RMSD between conformer atomic coordinates. This script executes the normalization of the atom number scheme in case the input structures have different atom numbering schemes and it is only comparing the heavy atoms (not H).


  ```bash
  #The first structure is taken as the reference, and the RMSD for all structures in the second position is calculate.
  $SCHRODINGER/run rmsd.py reference_ligand.mae sp1.pdb
  ```

- You will get the following output:


 ```bash
Reference file: /PATHWAY-TO/reference_ligand.mae
Query file: sp1.pdb
ASL: not atom.element H
In-place RMSD = 2.18; maxd = 4.38 between atoms  28 ( C28) and  27 ( C23); atoms ASL: not atom.element H
  ```


Note: The script must be executed within the folder where the files to be used are located, which can be in .mae or .pdb format, otherwise the path where it is located must be indicated before the name of the file.
- Example:


  ```bash
  $SCHRODINGER/run rmsd.py /PATHWAY-TO/reference_ligand.mae /PATHWAY-TO/sp1.pdb
  ```


2. Calculate the RMSD of a group of ligands:
- Using the same [rmsd.py](https://www.schrodinger.com/sites/default/files/s3/mkt/Documentation/current/docs/Documentation.htm#program_utility_usage/rmsd.html?TocPath=Command%2520References%257CProgram%252C%2520Script%252C%2520and%2520Utility%2520Usage%257C_____353) script to calculate the RMSD between conformer atomic coordinates.


  ```bash
  touch output.txt
  for i in *.mae; do $SCHRODINGER/run rmsd.py reference_ligand.mae $i>> output.txt;done
  ```
  - You will get a .txt file

This tutorial was created by [Claudia Martinez](https://github.com/Claudia-Alejandra-Martinez) and [Estanislao Márquez](https://github.com/estanislao741) - Ramirez Lab
