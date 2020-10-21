# Welcome to the Ramirez Lab Wiki – KNIME

Here we use a KNIME workflow to post-process the output file *CSV* from a multiple pharmacophore-based virtual screening calculation done with Phase. We screening a dataset of ~1000 compounds against multiple pharmacophores (~100), then the results were exported as a *CSV* file (see '/Files/screening_pahse_default.csv') with all the results with the corresponding phase screen score (0 to 1). This workflow organizes all the results and creates a matrix (compounds vs. pharmacophores) as well as a heatmap figure.


The workflow was programed with KNIME v 4.1.0, and can be found in '/Files/Pharmacophores_matrix.knwf'
