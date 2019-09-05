#!/bin/bash

################
#---PREAMBLE---#
################

# Hastily written by Benjamin Carter 2019-05-01 the night before his abstract was due.

# Operations: what does this script do? (aka outline of the steps and a minor explanation of why)
# 1. Creates seed ROIs for a resting state analysis
# 
# Requires: what does this script require to run?
# 1. Coordinates for your seed voxel in afni friendly RAI.

###################
#---ENVIRONMENT---#
###################

START=$(pwd) # save the directory you execute the script in.
DEST=~/Dropbox/Lab\ data\ \&\ Papers/analyses/restingSkilledReading/jahn/VWFA # where do you want the seed mask to get sent and what shall it be named?
REFER=~/Desktop/Luke_Reading_S11.results/ # where to refer to for dimensions

###############
#---COMMANDS--#
###############

# create tmp file with coordinates
cd ${REFER}
echo "-42, -44, -14" > tmp.txt

# make a spherical mask
3dUndump -prefix VWFA -master ${REFER}/errts.Luke_Reading_S11.tproject+tlrc. -srad 5 -xyz tmp.txt