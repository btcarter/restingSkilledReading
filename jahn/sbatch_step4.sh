#!/bin/bash

#SBATCH --time=3:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4gb   # memory per CPU core
#SBATCH -J "step4"   # job name
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

# Hastily written by Benjamin Carter 2019-04-27

# Operations: what does this script do? (aka outline of the steps and a minor explanation of why)
# 1. Extracts time course information via 3dmaskave
# 2. Generates correlation maps via 3dfim+
# 3. Converts maps to Z-maps
# 
# Requires: what does this script require to run?
# 1. Much, even your whole soul should you be unworthy or just the error timeseries (errts<stuff>+tlrc) file produced during step 2.

###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
REST_DIR=${STUDY_DIR}/resting
PARTICIPANT=${REST_DIR}/${1}
PART_RESU=${PARTICIPANT}/${1}.results
ANALYSIS=~/analyses/restingSkilledReading/jahn
MASK=${ANALYSIS}/VWFA+tlrc
OUT=VWFA

###############
#---COMMANDS--#
###############

# 1. extract time course
3dmaskave -quiet -mask ${MASK} ${PART_RESU}/errts.${1}.tproject+tlrc > ${PART_RESU}/timeCourse.txt

if [ ! -f ${PART_RESU}/timeCourse.txt ]; then
	echo I failed to extract the time course!
	exit 1
fi

# 2. create correlation maps
3dfim+ -input ${PART_RESU}/errts.${1}.tproject+tlrc -polort 0 -ideal_file ${PART_RESU}/timeCourse.txt -out Correlation -bucket ${PART_RESU}/${OUT}_Corr

if [ ! -f ${PART_RESU}/${OUT}_Corr ]; then
	echo I failed to create correlation maps!
	exit 1
fi

# 3. convert to Z maps
3dcalc -a ${PART_RESU}/${OUT}_Corr+tlrc -expr 'log((1+a)/(1-a))/2' -prefix ${PART_RESU}/${1}_ZMap

if [ ! -f ${PART_RESU}/${1}_ZMap ]; then
	echo I failed to create Z maps!
	exit 1
fi