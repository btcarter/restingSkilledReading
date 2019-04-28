# Skilled Reading: Resting State Analysis of the Visual Word Form Area

This repository contains the analysis scripts used to examine resting state data and determine who has some connectivity with the VWFA in Skilled Readers. These scripts were originally written by Nathan Muncy in the [Kirwan Memory Lab at BYU][1].

## Analysis steps
1. Conducted [term based automated meta-analysis via Neurosynth][2], 2019-04-08 with an FDR of 0.01. Coordinates with the highest Z-score in the left fusiform gyrus was selected as seed.
2. Generated template priors via antsCorticalThickness.sh.

## Jahn
This directory contains my version of a resting analysis based on a series of tutorials by [Andrew Jahn][3]. This is an older method but I'm going to employ it as a quick and dirty analysis to see if a more esoteric method is worth the effort. This analysis is not to be used for a paper, though a conference poster may not be out of the question.


[1]: https://github.com/Kirwanlab/LabScripts
[2]: http://neurosynth.org/analyses/terms/visual%20word/
[3]: https://www.andysbrainblog.com/andysbrainblog/2014/02/introduction-to-resting-state.html