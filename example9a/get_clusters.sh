#!/bin/bash
#AUTHORSHIP: Benjamin Carter, 2017-09-21
#PURPOSE: This uses the conjunction maps made by make_conjunction_mask.sh to do a cluster analysis and produce some numbers to describe the conjunction maps for all the numerophiles that might read your paper.

###########
#VARIABLES#
###########
WORK_DIR=~/Box/LukeLab/SkilledReadingStudy/results/resting
OUT_TXT=$WORK_DIR/resting_clusters.txt

##########
#COMMANDS#
##########

#Find and printout the center of mass for all ROI's
touch $OUT_TXT

3dclust -1Dformat -orient LPI -1dindex 0 -1tindex 1 -2thresh -3.291 3.291 -dxyz=1 1.01 38 ${WORK_DIR}/*.HEAD > $OUT_TXT

#End
