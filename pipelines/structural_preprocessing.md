# Structural Preprocessing Pipeline

1. DICOM conversion to NIfTI  
2. Gradient distortion unwarping [*GradUnwarp [Freesurfer?] https://surfer.nmr.mgh.harvard.edu/fswiki/GradUnwarp*]  
3. Readout distortion correction [*figure out what this is*]  
4. Rician denoising  
5. ACPC Alignment  
6. Within-session, within-modality averaging  
7. Brain extraction (preliminary)  
8. Bias field correction  
  a. T1/T2 debiasing [*T1 and T2 co-acquisition*]  
  b. N4 debiasing [*T1 only acquisition*]  
  c. Iterative N4 debiasing and segmentation [*atroposN4*]  
9. Brain extraction  
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
        ∟mask/
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_mask-brain.nii.gz
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_mask-tissue.nii.gz
```
10. Tissue segmentation  
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
        ∟segmentation/
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_seg-CSF.nii.gz
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_seg-GM.nii.gz
          ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_seg-WM.nii.gz
```
11. Coregistration  [*within-session only*]  
  - coregistering multiple acquisitions of the same modality within a scanning session  
  - coregistering multiple modalities within scanning sessions  
```
${researcherRoot}/
  ∟${projectName}/
    ∟derivatives/
      ∟anat/
      | ∟native/
      |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep.nii.gz
      ∟tform/
        ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_space-${acq}${mod}_tform-affine.mat
        ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_space-${acq}${mod}_tform-syn.nii.gz
```
12. Normalization
  - between session registrations, i.e., register to participant baseline or average  
  - registration to common space  
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
