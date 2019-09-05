#!/bin/bash


# written by Nathan Muncy on 11/7/17
# Butchered by Benjamin Carter 2019-04-25

### Wrapper script for RestingState_step1_sbatch_preproc.sh


WORK_DIR=~/compute/skilledReadingStudy
ANALYSIS=~/analyses/restingSkilledReading

# logfiles directory and output information
time=`date '+%Y_%m_%d-%H_%M_%S'`
LOG=~/logfiles/REST_${time}
mkdir -p $LOG


cd $WORK_DIR

for i in P*; do

    sbatch \
    -o ${LOG}/output_resting1_${i}.txt \
    -e ${LOG}/error_resting1_${i}.txt \
    ${ANALYSIS}/sbatch_step1.sh ${WORK_DIR} ${i}

    sleep 1
done
