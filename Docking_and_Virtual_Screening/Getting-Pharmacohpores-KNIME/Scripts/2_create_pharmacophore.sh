#!/bin/bash
# To run the script you need to install rename

cd result_clusters_sdf

# The cycle creates the hypotheses of pharmacophores for each file
echo ::::: Create hypotheses of pharmacophores :::::
echo
for dir in $(ls)
do

 echo Creating pharmacophores in: $dir

	cd /home/pvalenzuela/01_test/result_clusters_sdf/$dir/01_cluster_prep_$dir


	for a in *.inp
	do

        echo Para: $a
		$SCHRODINGER/utilities/phase_hypothesis ${a} -HOST localhost:10
		sleep 5m

        # Mover la carpeta phprj y archivo phypo.mae.gz a la carpeta farmacoforo
		mv *.phprj /home/pvalenzuela/01_test/result_clusters_sdf/$dir/02_pharmacophore_$dir/

		mv *phypo.mae.gz /home/pvalenzuela/01_test/result_clusters_sdf/$dir/02_pharmacophore_$dir/

	done

done
sleep 4m


echo
echo :::::::: Extract title and PhaseHypoScore Data :::::
# Extract data from the phypo.mae.gz file and generate a file in csv format
cd /home/pvalenzuela//01_test/result_clusters_sdf

for dir in $(ls)
do

echo Extract in: $dir

	cd /home/pvalenzuela//01_test/result_clusters_sdf/$dir/02_pharmacophore_$dir

    echo file: pharmacophore_$dir

	#extract table from schrodinger
	for b in *.mae.gz
	do
		echo pharmacophore file: $b
		$SCHRODINGER/utilities/proplister $b -p title -p PhaseHypoScore -c -o "$b".csv

	done
    sleep 30s

    #rename file
    for f in *.csv
    do
        rename 's/_prep-out_phypo.mae.gz.csv/.txt/' $f
    done

    # extract only charact of pharmacophore hypothesis and its Phase HyperScore
    for c in *.txt
    do
        grep -iE "_" $c | awk 'BEGIN{OFS=FS=","}{print $1"\t"$2}'  > "$c"_phasehyposcore
    done

    # rename file
    for h in *.txt_phasehyposcore
    do
        rename -v 's/.txt_phasehyposcore/.csv/' $h
    done

    rm *.txt_phasehyposcore
    rm *.txt
    rm *phypo.mae.gz.csv

     #rename the folder name
    for l in *_prep-out.phprj
    do
        rename -v 's/_prep-out.phprj/.phprj/' $l
        echo $l
    done


done
