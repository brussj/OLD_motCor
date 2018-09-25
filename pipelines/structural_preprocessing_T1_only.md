# Structural Preprocessing Pipeline
## T1 Only Acquisitions

1. DICOM conversion to NIfTI  
2. Gradient distortion unwarping *GradUnwarp [Freesurfer?] https://surfer.nmr.mgh.harvard.edu/fswiki/GradUnwarp*  
3. Readout distortion correction *figure out what this is*  
4. Rician denoising  
5. ACPC Alignment  
6. Within-session, within-modality averaging  
7. Brain extraction (preliminary)  
8. Debiasing  
  a. N4 debiasing  
  b. Iterative N4 debiasing and segmentation *atroposN4*  
9. Tissue segmentation  
10. Brain extraction  
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
        ∟masks/
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_mask-brain.nii.gz
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_mask-tissue.nii.gz
```
11. Coregistration   
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
        ∟native/
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep.nii.gz
```
11. Normalization
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
      | ∟reg_${space}/
      |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_reg-${space}.nii.gz
      ∟tform/
        ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_space-${space}_tform-affine.mat
        ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_space-${space}_tform-syn.nii.gz
```
