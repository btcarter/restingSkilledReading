#!/bin/bash
#
#
#
# Written by Nathan Muncy on 03/29/16, modified by Ben Carter April 23, 2018
# This script requires an a priori functional mask, created via the following command:
# 3dclust -1Dformat -nosum -1dindex 4 -1tindex 5 -2thresh -3.291 3.291 -dxyz=1 -savemask OrthoMask_mask 1.01 38 /Users/ben88/Documents/Research/fMRI_data/Reading/Compute_data/Group_Analysis1/predictability1/pred_lsa+tlrc.HEAD

### set variables - these are the only things you'll have to change

STUDY=/fslhome/ben88/compute/Reading
WORK_DIR=$STUDY/Compute_data/Group_Analysis1/predictability1
SUBJ_DIR=$STUDY/Compute_data/SubjData


### go

# Lexical Stats

STATS=$WORK_DIR/orthoStatsNZ
MASK=$WORK_DIR/OrthoMask_mask+tlrc

cd ${WORK_DIR}  # because who knows where you put this script

touch ${STATS}.txt     # make this for later

for i in $(ls $SUBJ_DIR); do
    cd ${SUBJ_DIR}/${i}/afni_data/predictability1

    stat=`3dROIstats -nzmean -nzminmax -nzsigma -mask ${MASK} '${SUBJ_DIR}/${i}/afni_data/predictability1/predictability_deconv_blur5_ANTS_resampled+tlrc[5]'`

    cd ${WORK_DIR}

    echo "${i} ${stat}" >> ${STATS}.txt        # keep things straight

done
