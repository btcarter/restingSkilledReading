#!/bin/bash

# Written by Benjamin Carter 2019-04-27

###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
ANALYSIS=~/analyses/restingSkilledReading/jahn
TIME=`date '+%Y_%m_%d-%H_%M_%S'`
LOG=~/logfiles/REST_${TIME}

###############
#---COMMANDS--#
###############

if [ ! -d ${LOG} ]; then
	mkdir -p ${LOG}
fi

# submit batch script for each one
sbatch \
	-o ${LOG}/output_resting5_${i}.txt \
	-e ${LOG}/error_resting5_${i}.txt \
	${ANALYSIS}/sbatch_step5.sh
