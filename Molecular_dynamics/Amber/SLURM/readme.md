
# Running Molecular simulations on Amber by SLURM queuing system on GPUs cluster of Universidad de Concepción#

This is an example configuration file to manage on SLURM MD calculations, for more information related to Amber settings check Amber documentation.

## 1. Remote conection to GPUs Cluster ##

Request access credentiasls to David Ramírez dramirezs@udec.cl

First connect to University network's ip 152.74.100.228:  
````
ssh dramirez@152.74.100.228
````
Then connect to GPUs Cluster with ip 152.74.16.235:
````
ssh dramirez@152.74.16.235
````
## 2. SLURM configuration file: ##

Write the following file on the same folder of your simulation files, remember modify the options to your system needs:

slurm.sch
````
#!/bin/bash
#SBATCH -J bm_2g20c
#SBATCH --partition=defq
#SBATCH -o bm_2g20c.log
#SBATCH --nodes=1
#SBATCH --tasks-per-node=20

module load mdynamics/amber/20.20

#Set for the system
GPU_COUNT=2
CPU_COUNT=20
CPU_PER_GPU=20

export CUDA_VISIBLE_DEVICES="0,1"

#minimization
#pmemd -O -i step6.0_minimization.mdin -p step5_input.parm7 -c step5_input.rst7 -o step6.0_minimization.mdout -r step6.0_minimization.rst7 -inf step6.0_minimization.mdinfo -ref step5_input.rst7

#equilibration
#pmemd.cuda -O -i step6.1_equilibration.mdin -p step5_input.parm7 -c step6.0_minimization.rst7 -o step6.1_equilibration.mdout -r step6.1_equilibration.rst7 -inf step6.1_equilibration.mdinfo -ref step5_input.rst7 -x step6.1_equilibration.nc
#pmemd.cuda -O -i step6.2_equilibration.mdin -p step5_input.parm7 -c step6.1_equilibration.rst7 -o step6.2_equilibration.mdout -r step6.2_equilibration.rst7 -inf step6.2_equilibration.mdinfo -ref step5_input.rst7 -x step6.2_equilibration.nc
#pmemd.cuda -O -i step6.3_equilibration.mdin -p step5_input.parm7 -c step6.2_equilibration.rst7 -o step6.3_equilibration.mdout -r step6.3_equilibration.rst7 -inf step6.3_equilibration.mdinfo -ref step5_input.rst7 -x step6.3_equilibration.nc
#pmemd.cuda -O -i step6.4_equilibration.mdin -p step5_input.parm7 -c step6.3_equilibration.rst7 -o step6.4_equilibration.mdout -r step6.4_equilibration.rst7 -inf step6.4_equilibration.mdinfo -ref step5_input.rst7 -x step6.4_equilibration.nc
#pmemd.cuda -O -i step6.5_equilibration.mdin -p step5_input.parm7 -c step6.4_equilibration.rst7 -o step6.5_equilibration.mdout -r step6.5_equilibration.rst7 -inf step6.5_equilibration.mdinfo -ref step5_input.rst7 -x step6.5_equilibration.nc
#pmemd.cuda -O -i step6.6_equilibration.mdin -p step5_input.parm7 -c step6.5_equilibration.rst7 -o step6.6_equilibration.mdout -r step6.6_equilibration.rst7 -inf step6.6_equilibration.mdinfo -ref step5_input.rst7 -x step6.6_equilibration.nc

#production

#multi-GPU
mpirun -np 2 $AMBERHOME/bin/pmemd.cuda.MPI -O -AllowSmallBox -i step7_production.mdin -p step5_input.parm7 -c step6.6_equilibration.rst7 -o step7_1.mdout -r step7_1.rst7 -inf step7_1.mdinfo -x step7_1.nc

#single-GPU
#pmemd.cuda -O -AllowSmallBox -i step7_production.mdin -p step5_input.parm7 -c step6.6_equilibration.rst7 -o step7_1.mdout -r step7_1.rst7 -inf step7_1.mdinfo -x step7_1.nc
````
Where: 

**#SBATCH -J :** Is the name of your job, useful to identify it from other users jobs running on the cluster.

**#SBATCH -o :** Is the name of the log file with job information and errors.

**GPU_COUNT:** Is the number GPUs to be used on the job calculation.

**CPU_COUNT:** Is the number of CPUs to be used on the job calculation.

**CPU_PER_GPU:** Is the number of CPUs tu be used along with the GPUs.

**export CUDA_VISIBLE_DEVICES:** Is a list with the GPU IDs selected to perform the simulation.

## 3. Run Calculations ##

* In the case of a system built with chamm-gui first run the following line from README file generated for Amber MDs commenting minimization, equilibration and production steps: "if (-e dihe.restraint) sed -e "s/FC/250.0/g" dihe.restraint > ${mini_prefix}.rest". This file allows minimization step to take the initial atom positions as reference limiting any extreme changes during minimization steps.

  Execution permissions to README file:
````
chmod 774 README
````
Execute README:
````
./README
````

* Submit MD job to SLURM:
````
sbatch slurm.sch
````
* Check running jobs and queues (JOBID):
````
squeue
````
* Cancel job:
````
scancel JOBID
````
