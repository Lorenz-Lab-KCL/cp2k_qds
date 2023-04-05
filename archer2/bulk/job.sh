#!/bin/bash
#SBATCH --job-name=InP_bulk
#SBATCH --nodes=10
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --account=e05-biosoft-lor
#SBATCH --partition=highmem
#SBATCH --qos=highmem
#SBATCH --export=all

# Load the relevant CP2K module
# Ensure OMP_NUM_THREADS is consistent with cpus-per-task above
# Launch the executable

module load epcc-setup-env
module load cp2k/cp2k-9.1

export OMP_NUM_THREADS=1
export OMP_PLACES=cores

find . -type d | sort -V | tail -n +2 > list_folders.tmp

# Proceeding with the calculations

for i in $(cat list_folders.tmp)
do
# Launch this subjob on 1 node, note nodes and ntasks options and & to place subjob in the background
    srun --nodes=1 --ntasks=128 --distribution=block:block --hint=nomultithread cp2k.popt -i $i/input.inp > $i/output.out &
done
# Wait for all background subjobs to finish
wait
