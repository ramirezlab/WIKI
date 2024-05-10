#!/bin/bash

cd resultados_clusters_sdf

# In the cycle the format of the sdf files is changed to mae, they are prepared with ligprep from schrodinger and the files are separated into folders according to the corresponding extension
echo ::::: Preparate LigPrep :::::
echo
for dir in $(ls)
do

cd $dir
	echo Running ligprep on: $dir

	#Leer y ejecutar comando de schrodinger por cada archivo sdf
	for i in *.sdf
	do

		echo sdf file: $i

		#CConvert from sdf to mae format, generating a new file
		$SCHRODINGER/utilities/sdconvert -isd ${i} -omae "$dir"_${i%.sdf}.mae

		#Prepare the molecules with ligprep (pH 7.4+/-0.2 and 1 ligand)
		$SCHRODINGER/ligprep -epik -ph 7.4 -pht 0.2 -s 1 -imae "$dir"_${i%.sdf}.mae -omae "$dir"_${i%.sdf}_prep-out.maegz -HOST localhost:5 -NJOBS 1 -TMPLAUNCHDIR

	done
	sleep 50s

		#Create folders to organize files by extension
		mkdir 01_pdb_"$dir"
		mv *.pdb 01_pdb_"$dir"

		mkdir 01_sdf_"$dir"
		mv *.sdf 01_sdf_"$dir"

		mkdir 01_cluster_mae_"$dir"
		mv *.mae 01_cluster_mae_"$dir"

		mkdir 01_ligprep_"$dir"
		mv *_prep.log 01_ligprep_"$dir"

		mkdir 01_cluster_prep_"$dir"
		mv *_prep-out.maegz 01_cluster_prep_"$dir"

		#the folder is created in the script 1_prepare_ligprep.sh but is used in 2_create_pharmacophore
		mkdir 02_pharmacophore_"$dir"

		#the folder is created in the script prepare_ligprep.sh but is used in 3_search_hypotheses
		mkdir 03_hypotheses_"$dir"

	#return to results_clusters_sdf
	cd ..
	echo
done

echo
echo ::::: Copy and rename inp and def files :::::
echo
# in the loop the .def and .inp files are copied and renamed
for dir in $(ls)
do
	# access the 01_test folder where the .inp and .def files are
	echo Copying and renaming in: $dir
    cd /home/pvalenzuela/01_prueba

	# copy the files file.inp and file.dep to cluster_prep_dir in each folder
    cp file.inp /home/pvalenzuela/01_prueba/resultados_clusters_sdf/$dir/01_cluster_prep_$dir
    cp file.def /home/pvalenzuela/01_prueba/resultados_clusters_sdf/$dir/01_cluster_prep_$dir

    # access the new path where the files are located (cluster_prep_$dir)
	cd /home/pvalenzuela/01_prueba/resultados_clusters_sdf/$dir/01_cluster_prep_$dir

	# change the name file inp and def to each file by those of the *.maegz files
    for j in *.maegz
    do

    echo name: $j
		sed "s/file/"${j%.*}"/g" /home/pvalenzuela/01_prueba/resultados_clusters_sdf/$dir/01_cluster_prep_$dir/file.inp > "${j%.*}".inp

		cp /home/pvalenzuela/01_prueba/resultados_clusters_sdf/$dir/01_cluster_prep_$dir/file.def "${j%.*}".def

	done
	rm file.inp file.def
	echo

 done
