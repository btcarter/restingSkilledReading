#!/bin/bash
#
#
#
# Written by Nathan Muncy on 03/29/16, modified by Ben Carter October 4, 2019
# This script requires an a priori functional mask, created via the following command:
# 3dclust -1Dformat -nosum -1dindex 4 -1tindex 5 -2thresh -3.291 3.291 -dxyz=1 -savemask OrthoMask_mask 1.01 38 <results file path>
# or by
# 3dClusterize -nosum -1Dformat -inset ${INPUT} -idat 0 -ithr 1 -NN 1 -clust_nvox 38 -bisided -3.291 3.291 -pref_map ${PREFIX}

### set variables - these are the only things you'll have to change

# Variables
STUDY=${HOME}/compute/skilledReading # path to main study directory
RESULTS=${STUDY}/resting/results # path to study results directory
SUBJ_DIR=${STUDY}/resting # path to directory containing participant data
STATS=${RESULTS}/part_cluster_stats # name of output file to hold the stats
MASK=${STUDY}/clusters+tlrc # path and name of mask file (previously generated).
SURVIVORS=${SUBJ_DIR}/survivors.txt # list of participants who survived motion censoring.

touch ${STATS}.txt     # start output file

for i in $(cat ${SURVIVORS}); do
    stat=`3dROIstats -nzmean -nzminmax -nzsigma -mask ${MASK} '${SUBJ_DIR}/${i}/${i}.results/Luke_Reading_S4_ZMap+tlrc[0]'`
    echo "${i} ${stat}" >> ${STATS}.txt        # keep things straight

done
