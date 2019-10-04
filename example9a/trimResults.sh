#!/bin/bash
#AUTHORSHIP: Benjamin Carter, 2019-10-03
#PURPOSE: This trims the non-brain voxels off the group results.

###########
#VARIABLES#
###########

WORK_DIR=${HOME}/Box/LukeLab/SkilledReadingStudy/results/resting
RESULTS=${WORK_DIR}/VWFA_resting+tlrc.
TEMPLATE=${WORK_DIR}/MNI152_T1_2009c+tlrc.
TRIMMED=${WORK_DIR}/trimmed_VWFA_resting+tlrc.

#COMMANDS
3dcalc -a ${TEMPLATE} -prefix ${TRIMMED} -expr "step(a)"
