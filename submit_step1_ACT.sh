#!/bin/bash

# Butchered by Benjamin Carter 2019-04-25

### Wrapper script for sbatch_step1_ACT.sh


WORK_DIR=~/compute/skilledReadingStudy
ANALYSIS=~/analyses/restingSkilledReading

# logfiles directory and output information
time=`date '+%Y_%m_%d-%H_%M_%S'`
LOG=~/logfiles/ACT_${time}
mkdir -p $LOG


cd $WORK_DIR

for i in P*; do

    sbatch \
    -o ${LOG}/output_ACT.txt \
    -e ${LOG}/error_ACT.txt \
    ${ANALYSIS}/sbatch_step1_ACT.sh

    sleep 1
done
