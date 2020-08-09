# Welcome to the Ramirez Lab Wiki - Molecular Dynamics Simulations

Here we explain how to properly load and visualize Desmond's trajectories in VMD. 

1. Open VMD and load a _desmond_trajectory-out.cms_ file as new molecule.
2. Load the _clickme.dtr_ trajectory file (it iss located into the _desmond_trajectory_trj_ folder) into the _desmond_trajectory-out.cms_ file.
3. To fix the periodix boundary conditions, you need to center the trajectory to generate a continuous trajectory view with the protein centered in the primary simulation box, to do that use the loaded trajectory and try either of the following commands from VMD’s Tk console (_Extensions_ > _Tk Console_): 
> pbc wrap -centersel protein -center com -compound res -all 

> pbc wrap -center bb -centersel protein -sel “not protein” -compound res -all 
4. You may have to superimpose all frames of the trajectory onto a selected frame in order to center the view in the main VMD graphics window. To do so, select _VMD_ > _Extensions_ > _Analysis_ > _RMSD Trajectory Tool_, and select the _Align_ option. Note that the transformed trajectory can be written to disk for further analysis.


Thanks!!!
