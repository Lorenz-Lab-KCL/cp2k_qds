


Introduction to CP2k using InP Quantum Dots
==============================================

In this repository, different examples for cp2k inputs can be found to perform, single point calculations, geometry relaxations 
and AIMD calculations (NVT at 300K) using a simple InP model. This repository is intended to have templates for users that would 
like to use this program to perform *ab-initio* calculations.


How to compute these structures:
=========================================


1. This repository can be cloned directly to Young by using this command:

.. code-block:: bash

   [~] git clone https://github.com/Lorenz-Lab-KCL/cp2k_qds.git

2. To submit the calculations, two steps must be carried out. First, within the **job_array.sh** file the following action needs to be
carried out:

.. code-block:: bash

   
