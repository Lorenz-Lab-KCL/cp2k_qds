Instructions how to use CP2k-AIMD:
=========================================

The input.inp contains the necessary options to run a CP2K-AIMD calculation. I have chosen a temperature of 1200K for exploring the PES.
I am using a NVT ensamble with a Nos'e-Hoover Thermostat in a box without periodic boundary conditions. In the begining of the input file, 
there is the @SET flag where the coordinates are defined and called mol. The extension is **.xyz**. This is for an initial run. 


How to submit:
=================

One needs to create a job.sh, which I think should be something like this:

.. code-block:: bash

  #!/bin/bash

  #SBATCH --job-name=CP2K_test
  #SBATCH --nodes=N
  #SBATCH --tasks-per-node=128
  #SBATCH --cpus-per-task=1
  #SBATCH --time=48:00:00

  #SBATCH --account=CHANGE
  #SBATCH --partition=standard
  #SBATCH --qos=standard
  #SBATCH --export=all

  # Load the relevant CP2K module
  # Ensure OMP_NUM_THREADS is consistent with cpus-per-task above
  # Launch the executable

  module load epcc-job-env
  module load cp2k/8.1


  export OMP_NUM_THREADS=1
  export OMP_PLACES=cores

  srun --hint=nomultithread --distribution=block:block cp2k.psmp -i input.inp > output.out


This will take advantage to the **mpi** parallelisation scheme, but not **openmp**. **cp2k.psmp** is compiled to exploit both, but in out case openmp
is not useful. 

Tracking the Calculation:
===========================

The output file (which is the file output.out) can be checked in the following matter:

.. code-block:: bash

   grep 'TEMP' output.out

Then, it will print something like:

.. code-block:: bash

    TEMPERATURE [K]              =                    1163.475             1098.372
    TEMPERATURE [K]              =                    1166.378             1098.407
    TEMPERATURE [K]              =                    1169.211             1098.445
    TEMPERATURE [K]              =                    1171.961             1098.483

This will indicate the instant temperature and the average temperature.


Restart:
=========

After the first round is finished. We need to change the **input.inp** file and grep the last geometry from the MD run to enable the restart option. To 
do so, you need to create a new folder called **0.1** inside the folder where the first AIMD calculation was performed. 

.. code-block:: bash

   [~] mkdir 0.1

The last geometry can be obtained via greping the trajectory file, which is done in this way:

.. code-block:: bash

   [~] grep -A 408 InP-ram-pos-1.xyz > last.xyz
    
The 408 is the number of atoms plus two spaces to print completely the last relaxed geometry. 

Then afterwards, I need that you copy **4** files into the folder **0.1**:

1. job.sh
2. input.inp
3. last.xyz
4. InP-ram-RESTART.wfn.bak-BIGGEST NUMBER

The third one **needs** to be the one with the biggest number after the **-bak-** suffix. Inside the **0.1** folder, you can rename it as:

.. code-block:: bash

   [~] mv InP-ram-RESTART.wfn.bak-BIGGEST NUMBER 0.1
   [~] cd 0.1
   [~] mv InP-ram-RESTART.wfn.bak-BIGGEST InP-ram-RESTART.wfn
   [~] mv last.xyz mol.xyz

The last step is to remove the **.bak-NUMBER** and leave it with a plain .wfn name. 

Once this is done, you can open it with a text editor the **input.inp** file, and uncomment the following lines:

.. code-block:: bash

   &ext_restart
    restart_file_name InP-ram-1.restart
   &end ext_restart

Once this is done, please check that the name of the restart_file is the same as the one we have in the folder. If not you can change it. This is the 
most important part for restarting and AIMD (this is the last converged wavefunction at that temperature).

Finally:

.. code-block:: bash

   [~] sbatch job.sh
   
and this is the way to restart a job. Everytime that the cpu-wall-time finished, we need to do the same steps, except changing the **input.inp**.
You can keep the record as 0.1, 0.2, 0.3 and so on. In the end, if we follow this numenclature, we can join all the trjectories and obtained the final
one. 



