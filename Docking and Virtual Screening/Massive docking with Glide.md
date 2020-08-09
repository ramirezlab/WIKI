# Welcome to the Ramirez Lab Wiki - Docking and Virtual Screening

Here we use Glide (Schrödinger Suite) to perform massive docking of one ligand into several conformations of the same receptor extracted from a molecular dynamics simulation. The idea is to include the flexibility of the receptor binding site (side chains) into a large conformational sampling. You should have the receptor frames in _.maegz_ format (_receptor_frame-1.maegz_, _receptor_frame-2.maegz_, _receptor_frame-3.maegz_, ... _receptor_frame-n.maegz_). Then you can use a tool to cluster the conformers and know which are the most visited poses.

You will need: [Glide | Schrödinger](https://www.schrodinger.com/glide). 

1. Preparing the Grid boxes:
- You need to align and save all the receptor files in a maestro type: _receptor_frame-1.maegz_, _receptor_frame-2.maegz_, _receptor_frame-3.maegz_, ... _receptor_frame-n.maegz_
- Using the **Receptor grid generation** panel in **Maestro**, generate the _IN.in_ and _SH.sh_ reference files with the desired dimentions of the grid boxes
  * Example of _IN.in_:
  ```bash
    GRID_CENTER   -25.4521884493, 22.4021285524, 35.6183791122
    GRIDFILE      receptor_frame-1.zip
    INNERBOX      10, 10, 10
    OUTERBOX      23.8189402677, 23.8189402677, 23.8189402677
    RECEP_FILE    receptor_frame-1.maegz
  ```
  
  * Example of _SH.sh_:
  ```bash
    "${SCHRODINGER}/glide" "IN.in" "-OVERWRITE" "-HOST" "localhost" "-TMPLAUNCHDIR" "-ATTACHED"
  ```

- Now, use the _replace_grid_mod.py_ to create the desired number of files _IN.in_ and _SH.sh_, in this example we created 10 grid files.
  * Example of _replace_grid_mod.py_:
  
  ```python
    #The range must bu n+1. Here we inted to create 10 files, so the range must be (1,11)
    for x in range(1,11):
      #name of the _IN.in_ and _SH.sh_ freference files created before
	    fin = open("IN.in", "rt")
	    data = fin.read()
	    fin2 = open("IN.sh", "rt")
	    data2 = fin2.read()
	    print (x)
	
      #Edit file _IN.in_. The following line change the name of _ZIP_ files taht will be generated and _.maegz_ previously generated to be included in the range.
	    data = data.replace('IN.zip', 'grid_%s.zip' % x)
	    data = data.replace('IN.maegz', '%s.maegz' % x)
	    fin.close()
	    fin = open("grid_%s.in" % x, "wt")
	    fin.write(data)
	    fin.close()
	  
      #Write the _SH.sh_ files.
      data2 = data2.replace('IN.in', 'grid_%s.in' % x)
	    fin2.close()
	    fin2 = open("grid_%s.sh" % x, "wt")
	    fin2.write(data2)
	    fin2.close()
  ```


- Now, use the _grid_runner.sh_ script to create the grid boxes with **Glide | Schrödinger** using the _IN.in_ and _SH.sh_ files previously created
  
  * Example of _grid_runner.sh_:
  
  ```bash
    #!/bin/bash
    #The range must be exactly
    for i in {1..10}
    do
      echo "Generating grid $i "
      ./grid_$i.sh
    done
  ```

- Now is time to dock!!! Using the **Docking Panel** in **Maestro** generate the template _dock.in_ and _dock.sh_ reference files with the desired docking configurations
  * Example of _dock.in_:
  ```bash
    GRIDFILE   grid_1.zip
    LIGANDFILE   Ligand-to-dock.maegz
    NREPORT   10
    POSES_PER_LIG   10
    POSTDOCK_NPOSE   10
    PRECISION   SP
  ```
  
  * Example of _dock.sh_:
  ```
    "${SCHRODINGER}/glide" "dock.in" "-OVERWRITE" "-NJOBS" "8" "-HOST" "localhost:8" "-TMPLAUNCHDIR" "-ATTACHED"
  ```

- Now, use the _replace_dock_mod.py_ to create the desired number of files _dock.in_ and _dock.sh_, in this example we created 10 docking files.
  * Example of _replace_dock_mod.py_:
  ```python
     #The range must bu n+1. Here we inted to create 10 files, so the range must be (1,11)
     for x in range(1,11):
	    fin = open("dock_1_template.in", "rt")
	    data = fin.read()
	    fin2 = open("dock_1_template.sh", "rt")
	    data2 = fin2.read()
	    print (x)
	      
     #Edit _IN.in_ file
	    data = data.replace('grid_1.zip', 'grid_%s.zip' % x)
	    fin.close()
	    fin = open("dock_%s.in" % x, "wt")
	    fin.write(data)
	    fin.close()
	
     #Edit _SH.sh_ file
	    data2 = data2.replace('dock_1.in', 'dock_%s.in' % x)
	    fin2.close()
	    fin2 = open("dock_%s.sh" % x, "wt")
	    fin2.write(data2)
	    fin2.close()

  ```


- Now, use the _docking_runner.sh_ script to run all docking simulations with **Glide | Schrödinger** using the _IN.in_ and _SH.sh_ files previously created.
  
  * Example of _docking_runner.sh_:
  
  ```bash
    #!/bin/bash
    #The range must be exactly
    for i in {1..10}
      do
      echo "correindo docking $i "
      ./dock_$i.sh
    done
  ```



Thanks!!!
