#!/bin/bash -l
# Batch script to run a serial array job under SGE.
#$ -l h_rt=48:00:00
#$ -l mem=4.5G
#$ -pe mpi 120
# Set up the job array. In this instance we have requested 10 tasks
# numbered 1 to 10.
#$ -t 1-25
# Set the name of the job.
#$ -N InP011
#$ -A KCL_Lorenz
#$ -P Gold
#$ -cwd 

# Loading needed modules
module purge
module load gerun
module load gcc-libs
module load compilers/gnu/4.9.2
module load mpi/openmpi/3.1.4/gnu-4.9.2
module load openblas/0.3.7-openmp/gnu-4.9.2
module load cp2k/7.1/ompi/gnu-4.9.2

# Only mpi parallelization
export OMP_NUM_THREADS=1

# Creating the list. Directories to be looped must be present in the same
# folders as this script is launched.
#find . -type d | sort -V | tail -n +2 > list_folders.tmp

# Proceeding with the calculations
INFILE=`sed -n "${SGE_TASK_ID}p" list_folders.tmp`
cd $INFILE
gerun cp2k.popt -inp input.inp > output.out
