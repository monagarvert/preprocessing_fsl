#!/bin/bash
#
# Copyright (c) Mona Garvert 2017, University of Oxford
#

subj=Subj_1
initials=ts

# Run Feat
for session in 3
do
    for run in 1 2 3 4
    do 
	echo Session $session Run $run

	dir=/home/fs0/mgarvert/scratch/ManyMaps/imagingData/$subj/session_$session
       	nvols=`fslnvols $dir/run_$run/funct_block_$run.nii.gz`

	
	../setFEAT /home/fs0/mgarvert/scratch/ManyMaps/imagingData/scripts/preprocessing/preprocess_template.fsf $dir/run_$run/preprocess.fsf -replace Subj_1 $subj -replace session_0 session_$session -replace run_1 run_$run -replace NVOLS $nvols -replace sliceOrder1 sliceOrder$run -replace block_1 block_$run

	feat $dir/run_$run/preprocess.fsf
    done
done
