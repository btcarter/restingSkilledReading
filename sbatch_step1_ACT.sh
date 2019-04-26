#!/bin/bash

#SBATCH --time=06:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=16384M  # memory per CPU core
#SBATCH --mail-user=ben88@byu.edu  # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# Compatibility variables for PBS. Delete if not needed.
export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch

# Set the max number of threads to use for programs using OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD ENVIRONMENTAL VARIABLES
vara=`id -un`
export ANTSPATH=/fslhome/$vara/apps/ants/bin/
PATH=${ANTSPATH}:${PATH}

# INSERT CODE, AND RUN YOUR PROGRAMS HERE

#######################
# --- ENVIRONMENT --- #
#######################

DATA_DIR=~/compute/skilledReadingStudy/template					# location of the study structural template
OASIS_30_DIR=~/templates/adult/OASIS-30_Atropos_template		# location of the reference template priors

####################
# --- COMMANDS --- #
####################
# ------------------
# OPERATIONS: these are performed once per participant as submitted.
# 1. Executes antsCorticalThickness.sh on your pre-constructed study structural template to create \
#	 the following:
# 	a. Priors
#	b. Tissue labels
#	c. Other stuff
#
# REQUIRES:
# 1. Study template image
# 2. OASIS-30-Atropos_template and priors
# ------------------

# check for priors
if [ ! -d ${OASIS_30_DIR} ]; then
	echo I have no priors to run with!
	exit 1
fi

# check for output directory
if [ ! -d ${DATA_DIR}/antsCT ]; then
	mkdir ${DATA_DIR}/antsCT
fi

# 1. antsCorticalThickness.sh
~/apps/ants/bin/antsCorticalThickness.sh \
-d 3 \
-a ${DATA_DIR}/dyce_mni_template.nii.gz \
-e ${OASIS_30_DIR}/T_template0.nii.gz \
-t ${OASIS_30_DIR}/T_template0_BrainCerebellum.nii.gz \
-m ${OASIS_30_DIR}/T_template0_BrainCerebellumProbabilityMask.nii.gz \
-f ${OASIS_30_DIR}/T_template0_BrainCerebellumExtractionMask.nii.gz \
-p ${OASIS_30_DIR}/Priors2/priors%d.nii.gz \
-q 1 \
-o ${DATA_DIR}/antsCT/


## COPY MASK
cp ${DATA_DIR}/antsCT/BrainExtractionMask.nii.gz ${DATA_DIR}/template_BrainCerebellumMask.nii.gz

## EXTRACT BRAIN IMAGE
${ANTSPATH}/ImageMath 3 ${DATA_DIR}/template_BrainCerebellum.nii.gz m ${DATA_DIR}/template_BrainCerebellumMask.nii.gz ${DATA_DIR}/dyce_mni_template.nii.gz

# CONVERT MASK ROI TO PROBABILITY MASK
${ANTSPATH}/SmoothImage 3 ${DATA_DIR}/template_BrainCerebellumMask.nii.gz 1 ${DATA_DIR}/template_BrainCerebellumProbabilityMask.nii.gz

# DILATE MASK IMAGE TO GENERATE EXTRACTION MASK
~/apps/c3d/bin/c3d ${DATA_DIR}/template_BrainCerebellumMask.nii.gz -dilate 1 28x28x28vox -o ${DATA_DIR}/template_BrainCerebellumExtractionMask.nii.gz

# DILATE MASK IMAGE TO GENERATE REGISTRATION MASK
~/apps/c3d/bin/c3d ${DATA_DIR}/template_BrainCerebellumMask.nii.gz -dilate 1 18x18x18vox -o ${DATA_DIR}/template_BrainCerebellumRegistrationMask.nii.gz

# COPY TISSUE SEGMENTATION
cp ${DATA_DIR}/antsCT/BrainSegmentation.nii.gz ${DATA_DIR}/template_6labels.nii.gz

# COPY TISSUE PRIORS
mkdir ${DATA_DIR}/priors/
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors1.nii.gz ${DATA_DIR}/priors/priors1.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors2.nii.gz ${DATA_DIR}/priors/priors2.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors3.nii.gz ${DATA_DIR}/priors/priors3.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors4.nii.gz ${DATA_DIR}/priors/priors4.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors5.nii.gz ${DATA_DIR}/priors/priors5.nii.gz
cp ${DATA_DIR}/antsCT/BrainSegmentationPosteriors6.nii.gz ${DATA_DIR}/priors/priors6.nii.gz
