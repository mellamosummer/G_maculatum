# sending job to the cluster script

#!/bin/sh

# Give the job a name (CHANGE py_test as desired)
#$ -N pysr_test

#$ -S /bin/sh

# set working directory on all host to
# directory where the job was started
#$ -cwd

# send output to job.log (STDOUT + STDERR)
#$ -o job.log
#$ -j y


# email information
#$ -m e
# Just change the email address.  You will be emailed when the job has finished.
#$ -M jarmanc@oregonstate.edu

# Request four cores
#$ -pe orte 4

#Change which version of R you want to load on the Compute Nodes
module load python/anaconda3-5.0.0.1
source activate base
conda activate myenv

# command to run.  ONLY CHANGE THE NAME OF YOUR PYTHON SCRIPT FILE
python test.py
