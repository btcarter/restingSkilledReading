#!/bin/bash

#SBATCH --time=0:30:00   # walltime
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
ANALYSIS=~/analyses/restingSkilledReading/jahn
MASK=${ANALYSIS}/VWFA+tlrc
OUT=VWFA

###############
#---COMMANDS--#
###############
3dttest++ \
-Clustsim \
-prefix ${REST_DIR}/${OUT}_resting \
-setA ${OUT} \
Luke_Reading_S1 ${REST_DIR}/Luke_Reading_S1/Luke_Reading_S1.results/Corr_subjLuke_Reading_S1_Z+tlrc'[0]' \
Luke_Reading_S2 ${REST_DIR}/Luke_Reading_S2/Luke_Reading_S2.results/Corr_subjLuke_Reading_S2_Z+tlrc'[0]' \
Luke_Reading_S4 ${REST_DIR}/Luke_Reading_S4/Luke_Reading_S4.results/Corr_subjLuke_Reading_S4_Z+tlrc'[0]' \
Luke_Reading_S5 ${REST_DIR}/Luke_Reading_S5/Luke_Reading_S5.results/Corr_subjLuke_Reading_S5_Z+tlrc'[0]' \
Luke_Reading_S7 ${REST_DIR}/Luke_Reading_S7/Luke_Reading_S7.results/Corr_subjLuke_Reading_S7_Z+tlrc'[0]' \
Luke_Reading_S8 ${REST_DIR}/Luke_Reading_S8/Luke_Reading_S8.results/Corr_subjLuke_Reading_S8_Z+tlrc'[0]' \
Luke_Reading_S9 ${REST_DIR}/Luke_Reading_S9/Luke_Reading_S9.results/Corr_subjLuke_Reading_S9_Z+tlrc'[0]' \
Luke_Reading_S11 ${REST_DIR}/Luke_Reading_S11/Luke_Reading_S11.results/Corr_subjLuke_Reading_S11_Z+tlrc'[0]' \
Luke_Reading_S12 ${REST_DIR}/Luke_Reading_S12/Luke_Reading_S12.results/Corr_subjLuke_Reading_S12_Z+tlrc'[0]' \
Luke_Reading_S14 ${REST_DIR}/Luke_Reading_S14/Luke_Reading_S14.results/Corr_subjLuke_Reading_S14_Z+tlrc'[0]' \
Luke_Reading_S16 ${REST_DIR}/Luke_Reading_S16/Luke_Reading_S16.results/Corr_subjLuke_Reading_S16_Z+tlrc'[0]' \
Luke_Reading_S17 ${REST_DIR}/Luke_Reading_S17/Luke_Reading_S17.results/Corr_subjLuke_Reading_S17_Z+tlrc'[0]' \
Luke_Reading_S18 ${REST_DIR}/Luke_Reading_S18/Luke_Reading_S18.results/Corr_subjLuke_Reading_S18_Z+tlrc'[0]' \
Luke_Reading_S19 ${REST_DIR}/Luke_Reading_S19/Luke_Reading_S19.results/Corr_subjLuke_Reading_S19_Z+tlrc'[0]' \
Luke_Reading_S20 ${REST_DIR}/Luke_Reading_S20/Luke_Reading_S20.results/Corr_subjLuke_Reading_S20_Z+tlrc'[0]' \
Luke_Reading_S22 ${REST_DIR}/Luke_Reading_S22/Luke_Reading_S22.results/Corr_subjLuke_Reading_S22_Z+tlrc'[0]' \
Luke_Reading_S23 ${REST_DIR}/Luke_Reading_S23/Luke_Reading_S23.results/Corr_subjLuke_Reading_S23_Z+tlrc'[0]' \
Luke_Reading_S25 ${REST_DIR}/Luke_Reading_S25/Luke_Reading_S25.results/Corr_subjLuke_Reading_S25_Z+tlrc'[0]' \
Luke_Reading_S26 ${REST_DIR}/Luke_Reading_S26/Luke_Reading_S26.results/Corr_subjLuke_Reading_S26_Z+tlrc'[0]' \
Luke_Reading_S28 ${REST_DIR}/Luke_Reading_S28/Luke_Reading_S28.results/Corr_subjLuke_Reading_S28_Z+tlrc'[0]' \
Luke_Reading_S29 ${REST_DIR}/Luke_Reading_S29/Luke_Reading_S29.results/Corr_subjLuke_Reading_S29_Z+tlrc'[0]' \
Luke_Reading_S30 ${REST_DIR}/Luke_Reading_S30/Luke_Reading_S30.results/Corr_subjLuke_Reading_S30_Z+tlrc'[0]' \
Luke_Reading_S33 ${REST_DIR}/Luke_Reading_S33/Luke_Reading_S33.results/Corr_subjLuke_Reading_S33_Z+tlrc'[0]' \
Luke_Reading_S35 ${REST_DIR}/Luke_Reading_S36/Luke_Reading_S36.results/Corr_subjLuke_Reading_S36_Z+tlrc'[0]' \
Luke_Reading_S36 ${REST_DIR}/Luke_Reading_S37/Luke_Reading_S37.results/Corr_subjLuke_Reading_S37_Z+tlrc'[0]' \
Luke_Reading_S37 ${REST_DIR}/Luke_Reading_S38/Luke_Reading_S38.results/Corr_subjLuke_Reading_S38_Z+tlrc'[0]' \
Luke_Reading_S45 ${REST_DIR}/Luke_Reading_S45/Luke_Reading_S45.results/Corr_subjLuke_Reading_S45_Z+tlrc'[0]' \
Luke_Reading_S47 ${REST_DIR}/Luke_Reading_S47/Luke_Reading_S47.results/Corr_subjLuke_Reading_S47_Z+tlrc'[0]' \
Luke_Reading_S48 ${REST_DIR}/Luke_Reading_S48/Luke_Reading_S48.results/Corr_subjLuke_Reading_S48_Z+tlrc'[0]' \
Luke_Reading_S50 ${REST_DIR}/Luke_Reading_S50/Luke_Reading_S50.results/Corr_subjLuke_Reading_S50_Z+tlrc'[0]' \
Luke_Reading_S51 ${REST_DIR}/Luke_Reading_S51/Luke_Reading_S51.results/Corr_subjLuke_Reading_S51_Z+tlrc'[0]' \
Luke_Reading_S52 ${REST_DIR}/Luke_Reading_S52/Luke_Reading_S52.results/Corr_subjLuke_Reading_S52_Z+tlrc'[0]' \
Luke_Reading_S54 ${REST_DIR}/Luke_Reading_S54/Luke_Reading_S54.results/Corr_subjLuke_Reading_S54_Z+tlrc'[0]' \
Luke_Reading_S55 ${REST_DIR}/Luke_Reading_S55/Luke_Reading_S55.results/Corr_subjLuke_Reading_S55_Z+tlrc'[0]' \
Luke_Reading_S56 ${REST_DIR}/Luke_Reading_S56/Luke_Reading_S56.results/Corr_subjLuke_Reading_S56_Z+tlrc'[0]'