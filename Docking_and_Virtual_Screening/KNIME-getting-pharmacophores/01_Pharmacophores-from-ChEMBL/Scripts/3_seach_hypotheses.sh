#!/bin/bash

echo ::::: Search hypotheses :::::

#mkdir all_hypotheses

cd /home/pvalenzuela/01_test/result_clusters_sdf/$dir/


#In the cycle, the best hypothesis is searched, considering the hyperscore phase, it is renamed with respect to the NameFolder_Cluster_CharacteristicsHypothesis and it is moved to a common folder where all the best hypotheses will be for each cluster
for dir in $(ls)
do
    echo Folder: $dir

    cd /home/pvalenzuela/01_test/result_clusters_sdf/$dir/02_pharmacophore_$dir/


    #File
    for q in *.csv
    do
    a=${q%.*}
    #echo File: $a

        #Folder
        for p in *.phprj
        do
        b=${p%.*}
        #echo Folder: $b

            #The condition indicates that both variables (folder and file) must have the same name
            if [[ "$a" == "$b" ]]; then

                hypo=$(awk 'BEGIN {FS=OFS="\t"}{print$1}' $q | head -1)
                echo Best hypotheses: $hypo

                #ls /home/pvalenzuela/01_test/result_clusters_sdf/$dir/pharmacophore_$dir/$a.phprj/hypotheses/* | grep $hypo


                cp /home/pvalenzuela/01_test/result_clusters_sdf/$dir/02_pharmacophore_$dir/$a.phprj/hypotheses/$hypo.phypo "${a%.*}"_$hypo.phypo

                echo Copying and moving the hypothesis: "${a%.*}"_$hypo.phypo
                echo

                mv *.phypo ../03_hypotheses_$dir


            fi
        done

    done

done

