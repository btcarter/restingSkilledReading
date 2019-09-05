# Skilled Reading: Resting State Analysis of the Visual Word Form Area

This repository contains the analysis scripts used to examine resting state data and determine who has some connectivity with the VWFA in Skilled Readers. These scripts were originally written by Nathan Muncy in the [Kirwan Memory Lab at BYU][1].

## Contents of this repository
1. Conducted [term based automated meta-analysis via Neurosynth][2], 2019-04-08 with an FDR of 0.01. Coordinates with the highest Z-score in the left fusiform gyrus was selected as seed.
2. Ran an analysis based on the output of the afni_proc.py script ([see Example 9a](https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/afni_proc.py_sphx.html)). These scripts can be found in the `example9a` directory. My abstract for the SfN poster was based on these results.
3. `restingSRP` contains my modified scripts, heavily based on the contents of `example9a`. I did this so I could utilize a model specific structural template rather than the general MNI template I chose for the first analysis.

## References used while creating this analysis

1. [Kirwan Lab scripts][1]
1. [Andrew Jahn's blogpost][3]
2. [Neurosynth's automated meta-analyses][2]

[1]: https://github.com/Kirwanlab/LabScripts
[2]: http://neurosynth.org/analyses/terms/visual%20word/
[3]: https://www.andysbrainblog.com/andysbrainblog/2014/02/introduction-to-resting-state.html
