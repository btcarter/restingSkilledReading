#!/bin/bash
#
# Author: Benjamin Carter
# Purpose:this script will extract coordinates from the output of 3dclust and turn them into a spherical mask for 3dROIstats

WORK_DIR=${HOME}/Box/LukeLab/SkilledReadingStudy/results/resting/sfn2019
PREFIX=${WORK_DIR}/roiMask # name for output
MASTER=${WORK_DIR}/trimmed_VWFA_resting+tlrc # reference dataset
RADIUS=10 # sphere radius
COORDS=${WORK_DIR}/resting_clusters_trimmed.txt # coordinates for Max Instensities


# make the mask
1dcat ${COORDS}[13,14,15] > ${WORK_DIR}/tmp.1D # output the voxel coords into a temp file (this was then manually edited to have a fourth column for the dval)
3dUndump -prefix ${PREFIX} -master ${MASTER} -srad ${RADIUS} -xyz ${WORK_DIR}/tmp.1D # make a mask
