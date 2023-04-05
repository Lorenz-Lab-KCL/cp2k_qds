High-Throughput in Archer2
=================================


First try to setup a succesful HTP calculation in ARCHER2. Let's run it in a small batch first and then we can expanded and hopefully finish this
HTP study faster. 

Steps
==========

1. git clone this repo into archer2
2. unzip the folder part_1.zip in archer 2
3. cp -r job.sh part_1 
4. cd part_1
5. sbatch job.sh

At this point, we have asked for 10 nodes and every single job will use only 1 node to perform the SP calculation. Let me know how it goes and if it works.
