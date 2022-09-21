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

After the first round is finished. We need to change the **input.inp** file to enable the restart option. 


