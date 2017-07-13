#!/bin/bash
#
# Copyright (c) Mona Garvert 2017, University of Oxford
#
# Moves data from scanner and converts dicom to nifti
# bet structural image

module add dcm2niix/current

subj=Subj_1
session=3
initials=ts

scanno=(3 5 9 11)
num=$(($session + 1))

# Set up folder structure
dir=/home/fs0/mgarvert/scratch/ManyMaps/imagingData/$subj/session_$session
mkdir $dir/struct
mkdir $dir/behaviour
mkdir $dir/fieldmap
mkdir $dir/physio

# Copy data
cp /vols/Data/MRdata/mgarvert/F3T_2017_008_00$num/*fieldmap* $dir/fieldmap
cp /vols/Data/MRdata/mgarvert/F3T_2017_008_00$num/*t1* $dir/struct
fslreorient2std $dir/struct/* 
fsl_sub -q veryshort.q bet $dir/struct/* $dir/struct/struct_brain.nii.gz -c 86 100 100

for file in $dir/struct/* 
do 
    bet $file struct_brain.nii.gz -f 0.36 
done

    
for run in 4
do 
    echo Run $run - Copy data
    
    mkdir $dir/run_$run


    # Copy directory
   cp -r /vols/Data/MRdata/mgarvert/F3T_2017_008_00$num/bold_mbep2d_MB3P2_TE20_TR1235_${scanno[($run-1)]}* $dir/run_$run

    echo Run $run - convert to nifti  

    # Convert dicom to nifti
    cd $dir/run_$run/bold_mbep2d_MB3P2_TE20_TR1235_${scanno[($run-1)]}*
    dcm2niix -y z . 
    mv *.nii.gz $dir/run_$run/funct_block_$run.nii.gz 

    # Remove directory
    rm -r $dir/run_$run/bold_mbep2d_MB3P2_TE20_TR1235_${scanno[($run-1)]}*

    fslreorient2std $dir/run_$run/funct_block_$run.nii.gz

done
