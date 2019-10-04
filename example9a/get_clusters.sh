#!/bin/bash
#AUTHORSHIP: Benjamin Carter, 2019-10-03
#PURPOSE: This grabs cluster statistics from the group results and puts them into a table.

###########
#VARIABLES#
###########
WORK_DIR=~/Box/LukeLab/SkilledReadingStudy/results/resting/sfn2019
INPUT=${WORK_DIR}/trimmed_*.HEAD
OUT_TXT=${WORK_DIR}/resting_clusters_trimmed.txt
PREFIX=${WORK_DIR}/clusters

##########
#COMMANDS#
##########

#Find and printout the center of mass for all ROI's
touch $OUT_TXT

3dclust -1Dformat -orient LPI -1dindex 0 -1tindex 1 -2thresh -3.291 3.291 -dxyz=1 1.01 38 ${INPUT} > $OUT_TXT

3dClusterize -nosum -1Dformat -inset ${INPUT} -idat 0 -ithr 1 -NN 1 -clust_nvox 38 -bisided -3.291 3.291 -pref_map ${PREFIX}

#End
