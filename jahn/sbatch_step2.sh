#!/bin/bash

#SBATCH --time=12:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4gb   # memory per CPU core
#SBATCH -J "step2"   # job name
#SBATCH --mail-user=ben88@byu.edu  # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# Compatibility variables for PBS. Delete if not needed.
export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

################
#---PREAMBLE---#
################

# Written by Benjamin Carter 2019-04-27

# Operations: what does this script do? (aka outline of the steps and a minor explanation of why)
# 1. Submits the tcsh script generated by afni_proc.py
# 
# Requires: what does this script require to run?
# 1. A script generated by afni_proc.py in step 1.


###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
REST_DIR=${STUDY_DIR}/resting
PARTICIPANT=${REST_DIR}/${1}

###############
#---COMMANDS--#
###############
cd ${PARTICIPANT}
tcsh -xef proc.${1} 2>&1 | tee output.proc.${1}
