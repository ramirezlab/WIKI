# Welcome to the Ramirez Lab Wiki - Docking and Virtual Screening

Here we use AutoDock Vina to perform massive docking of one ligand: 100 runs -> top-10 poses per run -> 1000 poses. The idea is to use a single ligand and do multiple dockings on the same receptor to extend the conformational sampling of that ligand. Then you can use a tool to cluster the conformers and know which are the most visited poses during the molecular docking.

You will need: [Vina](http://vina.scripps.edu/download.html), [Vina_split](https://github.com/ramirezlab/WIKI/tree/master/Docking%20and%20Virtual%20Screening/Files) & [Openbabel](http://openbabel.org/wiki/Main_Page) installed in your computer. Also the _input.conf_ file with the configuration, and the script _loop_vina.sh_.


#### Example of _input.conf_
```json
receptor = /path/to/receptor/receptor.pdbqt

center_x = -14.33
center_y = -41.71
center_z = -25.95
size_x =  30
size_y =  30
size_z =  30

out = /path/to/results/results.docked.pdbqt
log = /path/to/results/results.docked.log
cpu = 4
num_modes = 1
```



#### loop_vina.sh

```bash
#####################################################################
############# Created by Jessika Martinez - Ramirez Lab #############
#####################################################################

##Carry out the first Docking and convert the outputs from .pdbqt to .pdb
for i in {1..1}
do
	mkdir output
	mkdir pdbqt
	mkdir ./pdbqt/splitpdbqt1/
	mkdir ./pdbqt/merge/
	/path/to/vina --config input.conf --out ./pdbqt/merge/ligand$i.pdbqt >> ./output/output$i.log
	/path/to/vina_split --input ./pdbqt/merge/ligand1.pdbqt --ligand ./pdbqt/splitpdbqt1/ligand
	for e in {1..9}
	do
		/path/to/babel -d ./pdbqt/splitpdbqt1/ligand0$e.pdbqt -r ./pdbqt/splitpdbqt1/ligando0$e.pdb
	done
		/path/to/babel -d ./pdbqt/splitpdbqt1/ligand10.pdbqt -r ./pdbqt/splitpdbqt1/ligando10.pdb
done

#Carry out 4 more Docking taking random the 10 first structures and convert all of them from .pdbqt to .pdb

for a in {2..5}
do
	mkdir ./pdbqt/splitpdbqt$a
	/path/to/vina --config input.conf --ligand ./pdbqt/splitpdbqt1/ligand0$((RANDOM % (10 - 1 + 1 ) + 1 )).pdbqt --out ./pdbqt/merge/ligand$a.pdbqt >> ./output/output$a.log
	/path/to/vina_split --input ./pdbqt/merge/ligand$a.pdbqt --ligand ./pdbqt/splitpdbqt$a/ligand
       for e in {1..9}
       do      
               /path/to/babel -d ./pdbqt/splitpdbqt$a/ligand0$e.pdbqt -r ./pdbqt/splitpdbqt$a/ligando0$e.pdb
       done
               /path/to/babel -d ./pdbqt/splitpdbqt$a/ligand10.pdbqt -r ./pdbqt/splitpdbqt$a/ligando10.pdb
done

#Carry out 45 more Docking taking random the 50 previous structures and convert all of them from .pdbqt to .pdb

for t in {6..50}
do
    mkdir ./pdbqt/splitpdbqt$t
	/path/to/vina --config input.conf --ligand ./pdbqt/splitpdbqt$(( RANDOM % (5 - 1 + 1 ) + 1 ))/ligand0$(( RANDOM % (9 - 1 + 1 ) + 1 )).pdbqt --out ./pdbqt/merge/ligand$t.pdbqt >> ./output/output$t.log
	/path/to/vina_split --input ./pdbqt/merge/ligand$t.pdbqt --ligand ./pdbqt/splitpdbqt$t/ligand
       for y in {1..9}
       do
              /path/to/babel -d ./pdbqt/splitpdbqt$t/ligand0$y.pdbqt -r ./pdbqt/splitpdbqt$t/ligando0$y.pdb
       done
              /path/to/babel -d ./pdbqt/splitpdbqt$t/ligand10.pdbqt -r ./pdbqt/splitpdbqt$t/ligando10.pdb
done

#Carry out 50 more Docking taking random the 500 previous structures and convert all of them from .pdbqt to .pdb

for u in {51..100}
do
        mkdir ./pdbqt/splitpdbqt$u
       /path/to/vina --config input.conf --ligand ./pdbqt/splitpdbqt$(( RANDOM % (50 - 1 + 1 ) + 1 ))/ligand0$(( RANDOM % (9 - 1 + 1 ) + 1 )).pdbqt --out ./pdbqt/merge/ligand$u.pdbqt >> ./output/output$u.log
       /path/to/vina_split --input ./pdbqt/merge/ligand$u.pdbqt --ligand ./pdbqt/splitpdbqt$u/ligand
       for w in {1..9}
       do
              /path/to/babel -d ./pdbqt/splitpdbqt$u/ligand0$w.pdbqt -r ./pdbqt/splitpdbqt$u/ligando0$w.pdb
       done
              /path/to/babel -d ./pdbqt/splitpdbqt$u/ligand10.pdbqt -r ./pdbqt/splitpdbqt$u/ligando10.pdb
done


```


Thanks !!!
