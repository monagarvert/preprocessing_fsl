#!/bin/bash
#
# Copyright (c) Mona Garvert, University of Oxford
#
# Generates voxel-wise physio regressors from text file
#

subj=1
initials=ts

# Run Pnm
for session in 3
do
    for run in 1 2 3 4
    do 
	echo Session $session
	echo Run $run
	dir=/home/fs0/mgarvert/scratch/ManyMaps/imagingData/Subj_$subj/session_$session
	mkdir $dir/run_$run/physio/

	/opt/fmrib/fsl/bin/fslFixText $dir/physio/Subj_${subj}_ts_session${session}_run$run.txt $dir/run_$run/physio/physio_input.txt
	/opt/fmrib/fsl/bin/pnm_stage1 -i $dir/run_$run/physio/physio_input.txt -o $dir/run_$run/physio/physio -s 50 --tr=1.235 --rvt --smoothcard=0.1 --smoothresp=0.1 --resp=2 --cardiac=4 --trigger=3 
	/opt/fmrib/fsl/bin/popp -i $dir/run_$run/physio/physio_input.txt -o $dir/run_$run/physio/physio -s 50 --tr=1.235 --rvt --smoothcard=0.1 --smoothresp=0.1 --resp=2 --cardiac=4 --trigger=3
       
	/opt/fmrib/fsl/bin/pnm_evs -i $dir/run_$run/funct_block_$run.nii.gz -o $dir/run_$run/physio/physio_ev --tr=1.235 -c $dir/run_$run/physio/physio_card.txt --oc=3 -r $dir/run_$run/physio/physio_resp.txt --or=3 --rvt=$dir/run_$run/physio/physio_rvt.txt --slicetiming=$dir/scripts/sliceOrder$run.txt

	$dir/run_$run/physio/physio_pnm_stage2

	ls $dir/run_$run/physio/*.nii.gz > $dir/run_$run/physio/evlist.txt
    done
done
