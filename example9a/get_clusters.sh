#!/bin/bash
#AUTHORSHIP: Benjamin Carter, 2017-09-21
#PURPOSE: This uses the conjunction maps made by make_conjunction_mask.sh to do a cluster analysis and produce some numbers to describe the conjunction maps for all the numerophiles that might read your paper.

###########
#VARIABLES#
###########
START_DIR=$(pwd)
WORK_DIR=~/Box/LukeLab/SkilledReadingStudy/results/resting
OUT_TXT=$WORK_DIR/resting_clusters.txt

##########
#COMMANDS#
##########

cd $WORK_DIR

#Find and printout the center of mass for all ROI's
touch $OUT_TXT

3dclust -1Dformat -orient LPI -1dindex 0 -1tindex 0 -1thresh 3 -dxyz=1 1.75 0 ${WORK_DIR}/$*.HEAD > $OUT_TXT

cd $START_DIR
#End
