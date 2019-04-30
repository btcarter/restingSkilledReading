#!/bin/bash

#SBATCH --time=00:30:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8gb   # memory per CPU core
#SBATCH -J "afni_proc.py"   # job name
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
# 1. Ensures proper file structure is present and if not creates it.
# 2. Converts resting DICOMs NIFTIs
# 3. Runs afni_proc.py to generate a resting state processing command.
# 
# Requires: what does this script require to run?
# 1. A resting state EPI
# 2. A structural template
# 3. A participant structural file
#


###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
DICOMS=${STUDY_DIR}/dicomdir/${1}/EPI_RESTING*
REST_DIR=${STUDY_DIR}/resting
PARTICIPANT=${REST_DIR}/${1}
D2N=~/apps/dcm2niix/bin/dcm2niix
PART_REST=${PARTICIPANT}/${1}_T2wRest.nii.gz
PART_STRUC=${STUDY_DIR}/structural/${1}/${1}_T1w.nii
BASE=${STUDY_DIR}/template/dyce_mni_template.nii.gz			# structural reference dataset, originally MNI152_T1_2009c+tlrc

###############
#---COMMANDS--#
###############

# 1. Is everything here?

if [ ! -d ${STUDY_DIR} ]; then
	echo No study directory, I must die!
	exit 1
fi

if [ ! -d ${REST_DIR} ]; then
	mkdir ${REST_DIR}
	exit 1
fi

if [ ! -f ${DICOMS} ]; then
	echo There are no dicoms. There is no food to sustain me. I must die!
	exit 1
fi

# 2. Check for NIFTIs or make them from the DICOMs
if [ ! -f ${PART_REST} ]; then
	mkdir -p ${PARTICIPANT}
	cd ${PARTICIPANT}
	${D2N} \
	-z n \
	-x y \
	-o ${PARTICIPANT} \
	-i ${DICOMS}
	mv ${PARTICIPANT}/*Crop*.nii ${PART_REST}
fi

if [ ! -f ${PART_REST} ]; then
	echo I failed and must die!
	exit 1
fi

echo Pushed pushed NIFTIs.

# 3. Create resting state processing command in resting state directory
cd ${PARTICIPANT}
afni_proc.py -subj_id ${1}          		                      \
       -dsets ${PART_REST}     		                              \
       -copy_anat ${PART_STRUC}                                   \
       -blocks despike tshift align tlrc volreg blur mask         \
               scale regress                                      \
       -tcat_remove_first_trs 3                                   \
       -tlrc_base ${BASE}			                              \
       -tlrc_NL_warp                                              \
       -volreg_align_e2a                                          \
       -volreg_tlrc_warp                                          \
       -mask_epi_anat yes                                         \
       -regress_censor_motion 0.2                                 \
       -regress_censor_outliers 0.05                              \
       -regress_bandpass 0.01 0.1                                 \
       -regress_apply_mot_types demean deriv                      \
       -regress_est_blur_epits                                    \
       -regress_est_blur_errts
       
#source what is the script called?