# Welcome to the Ramirez Lab Wiki – KNIME

Here we use a KNIME workflow to post-process the output file *CSV* from a multiple pharmacophore-based virtual screening calculation done with Phase. We screening a dataset of ~1000 compounds against multiple pharmacophores (~100), then the results were exported as a *CSV* file (see [*/Files/screening_phase_default-otro.csv*](https://github.com/ramirezlab/WIKI/blob/master/KNIME/Files/screening_phase_default-otro.csv)) with all the results with the corresponding phase screen score (0 to 1). This workflow organizes all the results and creates a matrix (compounds vs. pharmacophores) as well as a heatmap figure.




The workflow was programed with KNIME v 4.1.0, and can be found at [*/Files/Pharmacophores_matrix.knwf*](https://github.com/ramirezlab/WIKI/blob/master/KNIME/Files/Pharmacophores_matrix.knwf)

### Workflow
![Imagen](https://github.com/ramirezlab/WIKI/blob/master/KNIME/Files/Pharmacofore.png)


Created by Carlos Peña-Varas - Ramirez Lab


Have fun!!!



