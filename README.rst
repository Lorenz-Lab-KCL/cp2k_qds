


Introduction to CP2k using InP Quantum Dots
==============================================

In this repository, different examples for cp2k inputs can be found to perform, single point calculations, geometry relaxations 
and AIMD calculations (NVT at 300K) using a simple InP model. This repository is intended to have templates for users that would 
like to use this program to perform *ab-initio* calculations.


How to compute these structures:
=========================================


1. This repository can be cloned directly to Young by using this command:

.. code-block:: bash

   git clone https://github.com/Lorenz-Lab-KCL/cp2k_qds.git
 
Then, a small folder reorganization is needed via:

.. code-block:: bash

   [~] cd cp2k_qds
   [~] rm -r bibliography/ InP_Kurf_WP.odt README.rst

2. Change to the directory where the structures are stored:

.. code-block:: bash

   [~] cd relaxed_structures/InP111/

3. To submit the calculations, two steps must be carried out. First, within the **job_array.sh** file the following action needs to be
carried out:

.. code-block:: bash

   #$ -P NAME_OF_MCC_PROJECT
   
To ensure you are using your **MCC budget** project.

then:

.. code-block:: bash
 
   [~] qsub job_array.sh

and that should work. 

Note
^^^^

The **input.inp** file can be seen as a template to relax the structures. This is basically what we need to perform Geo_Opt in Young.
