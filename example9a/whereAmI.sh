#!/bin/bash

#this script will take 1D input for ROI regions and produce a table with Anatomical location names
#refer to the AFNI help files for more info: https://afni.nimh.nih.gov/pub/dist/doc/program_help/whereami.html and https://afni.nimh.nih.gov/pub/dist/edu/latest/afni11_roi/afni11_roi.pdf
#Usage whereami [x y z [output_format]] [-lpi/-spm] [-atlas ATLAS]

#VARIABLES
START=$(pwd)
WORK_DIR=/Users/ben88/Documents/Research/fMRI_data/Reading/Compute_data/Group_Analysis2

#COMMANDS
for i in 1 3 5; do

    cd ${WORK_DIR}/predictability${i}
    sleep 1
    whereami -coord_file predictability_regions.txt'[13,14,15]' -tab -lpi -space MNI > region_atlas.txt

done

cd $START
