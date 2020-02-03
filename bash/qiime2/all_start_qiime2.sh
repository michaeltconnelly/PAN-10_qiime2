#!/bin/bash
#purpose: create directory structure, copy program binaries and reference sequences on local computer
#conda activate qiime2-2019.10

prodir="/Users/mikeconnelly/computing/projects/PAN-10_qiime2"
echo "Pipeline setup process started"

#make file structure for pipeline file input/output
mkdir ${prodir}/outputs/qiime2
mkdir ${prodir}/outputs/qiime2/qza
mkdir ${prodir}/outputs/qiime2/qzv
mkdir ${prodir}/outputs/qiime2/QC
mkdir ${prodir}/outputs/qiime2/export_silva

bash ${prodir}/bash/qiime2/all_importqc_qiime2.sh
