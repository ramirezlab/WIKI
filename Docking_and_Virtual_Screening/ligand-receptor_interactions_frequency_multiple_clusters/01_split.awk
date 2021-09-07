echo "Processing data ..."

for f in *.maegz; do
    $SCHRODINGER/run split_structure.py ${f} -m ligand -k -many_files ${f%.maegz}.mae    
done 
echo "Done!!"
