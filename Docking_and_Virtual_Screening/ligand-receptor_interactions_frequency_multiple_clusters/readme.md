# Welcome to the Ramirez Lab Wiki - Docking post-processing: Interaction frequency among multiple-cluster conformers #

To analyze the frequency of receptor-ligand interactions on a set of poses from different clusters, we use scripts included on Schrödinger Suit (v.2020-3) to calculate the interactions on every pose and a *in-house* functional workflow built on [Knime](https://www.knime.com/) to get the frequency of interactions on each cluster and then sum the total.
## Requirements ##
- Schrödinger Suit (version 2020 or newer; comercial or academic version) [Schrödinger](https://www.schrodinger.com/).
- Knime version 4.3.2 or higher, a programing software via functional workflows. [Knime website](https://www.knime.com/).
- Our *in-house* Knime workflow to calculate interaction frequencies. [Cluster-interactions-frequency](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency/03_cluster_interactions_frequency.knwf).
- A set of receptor-ligand complexes from a single cluster. All complexes must be of the same receptor and ligand. They can be obtained from different docking simulations, from a molecular dynamics trajectory, or even from free energy calculations.
To test this pipeline, skipping steps 1 and 2, we provide an example ready for the workflow, with 7 clusters with all interactions already calculated (*csv* files), and separated into different folders. [Example cluster set](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/01_System1_7clusters_example_set.zip).

## 1. Split ligand-receptor complexes and calculate interactions ##

Follow steps 1 and 2 of [Interaction frequency among single-cluster conformers](https://github.com/ramirezlab/WIKI/tree/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency).

## 2. Split clusters into folders ##

Make sure that each cluster has their own separated folder containing interactions files (*.csv). See the [Example cluster set](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/01_System1_7clusters_example_set.zip).

## 3. Calculate interaction frequencies for user defined ligand fragments ##
To calculate the interaction frequency of each ligand-receptor complex cluster we use the Knime workflow [Multiple_clusters_interactions_frequency](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/02_Multiple-Clusters_interactions_frequency.knwf). The user must to configure 2 nodes:
- **List Files/Folders:** The user must select the parent folder where separated cluster directories are located.
- **Table Creator:** The user need to list all ligand atoms **(use only PDB format atom names)** on the first column, and assign each atom to the fragment of the structure it belongs to. Visit [Interaction frequency among single-cluster conformers](https://github.com/ramirezlab/WIKI/tree/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency) for an example of maping ligands.

## 4. Results ##

The results table shows ligand framents, interacting residues and the sum of frequencies of clusters. [Download results file](https://github.com/ramirezlab/WIKI/raw/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/03_results.xlsx)

<p align="center">
    <img src="https://raw.githubusercontent.com/ramirezlab/WIKI/master/Docking_and_Virtual_Screening/ligand-receptor_interactions_frequency_multiple_clusters/media/Results.png" width="900">
</p>

## Citing
