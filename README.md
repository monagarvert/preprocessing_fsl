# preprocessing_fsl

Preprocessing procedure

1.	Download data from https://www.fmrib.ox.ac.uk/bookings/

2.	Run dcm_convert_data.sh to set up data structure, move data from /vols, convert dicom to nifty files, rename functional and structural scans, bet structural 

3.	Check bet for structural images

4.	Rename fieldmap to fieldmap_mag and fieldmap_phase and preprocess fieldmap:

Bet the magnitude image using a more aggressive bet threshold (e.g. 0.55). Apply an erosion to the image using fslmaths. If the image still contains voxels outside the brain remove these in fslview. 

bet fieldmap_mag.nii.gz fieldmap_mag_brain.nii.gz -f 0.55

fslmaths fieldmap_mag_brain.nii.gz –ero fieldmap_mag_ero_brain.nii.gz 

Ensure the folder also contains the raw magnitude image as fieldmap_mag_ero.nii.gz

Generate the fieldmap:

fsl_prepare_fieldmap <scanner> <phase_image> <magnitude_image (bet, ero)> <out_image> <deltaTE (in ms)>

5.	Create physio regressors by running generate_physio_regressors.sh

6.	Perform preprocessing by running run_preprocessing.sh

