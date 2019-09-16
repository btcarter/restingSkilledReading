#!/bin/bash

# Written by Benjamin Carter 2019-04-27

###################
#---ENVIRONMENT---#
###################

START=$(pwd)
STUDY_DIR=~/compute/skilledReadingStudy
PART_LIST=$(ls ${STUDY_DIR}/resting)
ANALYSIS=~/analyses/restingSkilledReading/jahn
TIME=`date '+%Y_%m_%d-%H_%M_%S'`
LOG=~/logfiles/REST_${TIME}
SURVIVORS=${STUDY_DIR}/resting/survivors.txt
CENSORED=${STUDY_DIR}/resting/censored.txt

###############
#---COMMANDS--#
###############

if [ ! -d ${LOG} ]; then
	mkdir -p ${LOG}
fi

# make a list of subjects who survived censoring
touch ${SURVIVORS}
touch ${CENSORED}

# submit batch script for each one
for i in ${PART_LIST}; do
	if [ -f ${STUDY_DIR}/resting/${i}/${i}.results/errts.${i}.tproject+tlrc.BRIK ]; then
		echo ${i} >> ${SURVIVORS}
		sbatch \
			-o ${LOG}/output_resting4_${i}.txt \
			-e ${LOG}/error_resting4_${i}.txt \
			${ANALYSIS}/sbatch_step4.sh ${i}
		sleep 1
	else
		echo ${i} >> ${CENSORED}
	fi
done