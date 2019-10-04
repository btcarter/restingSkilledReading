#!/bin/bash
#AUTHORSHIP: Benjamin Carter, 2019-10-03
#PURPOSE: This trims the non-brain voxels off the group results.

###########
#VARIABLES#
###########

WORK_DIR=${HOME}/Box/LukeLab/SkilledReadingStudy/results/resting/sfn2019
RESULTS=${WORK_DIR}/VWFA_resting+tlrc.HEAD
TEMPLATE=${WORK_DIR}/MNI152_T1_2009c+tlrc.HEAD
TMP=${WORK_DIR}/tmp
TRIMMED=${WORK_DIR}/trimmed_VWFA_resting+tlrc.HEAD

#COMMANDS
3dcalc -a ${TEMPLATE} -prefix ${TMP} -expr "step(a)" # make a mask
3dresample -master ${RESULTS} -input ${TMP}*.HEAD -prefix ${TMP}_resample # downsample to functional resolution of 3^3 voxels.
3dcalc -a ${RESULTS} -b ${TMP}_resample*.HEAD -prefix ${TRIMMED} -expr 'a * b'  # use mask for trimming
