#!/bin/bash

# Written by Benjamin Carter 2019-04-27

###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
PART_LIST=$(ls ${STUDY_DIR}/dicomdir)
ANALYSIS=~/analyses/restingSkilledReading/jahn
LOG=~/logfiles

###############
#---COMMANDS--#
###############

for i in ${PART_LIST}; do
	sbatch \
		-o ${LOG}/output_resting1_${i}.txt \
		-e ${LOG}/error_resting1_${i}.txt \
		${ANALYSIS}/sbatch_step1.sh ${i}
done