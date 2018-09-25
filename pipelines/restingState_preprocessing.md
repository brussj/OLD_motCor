# Resting State fMRI Preprocessing Pipeline
1. DICOM conversion to NIfTI
  a. Assumes that anat (*T1*) to atlas (*standard*) transforms already exist
  b. Create anat to standard transforms if missing (*2x2x2, 3x3x3 space?*)
  c. Allow for multiple standard atlas transforms
    - MNI152
    - MNI 2009c
    - CIT168
    - HCP S1200
    - Koscik HCP
2. Reorient to RPI/LPI
3. Motion correction (*e.g. https://stnava.github.io/fMRIANTs , https://github.com/ANTsX/ANTsR/blob/master/R/preprocessfMRI.R#L44-L46*)
  a. 3dvolreg (*AFNI*)
  b. mcflirt (*FSL*)
  c. antsMotionCorr (*ANTs*)
    - affine or affine & deformable correction
      1. Average the time series (*for registration*)
      2. Might be possible to do both in one step (*-o [outputTransformPrefix,<outputWarpedImage>,<outputAverageImage>]*)
    - Target scan of average volume or halway point?
      1. Average the time series with antsMotionCorr, and align to that (*then optionally update average and correct again*)
    - Average of motion corrected TRs
    - Output motion parameters for regression?
    - Mask creation of average motion corrected volume
7. Bias field correction  
  a. T1/T2 debiasing [*T1 and T2 co-acquisition*]  
  b. N4 debiasing [*T1 only acquisition*]  
  c. Iterative N4 debiasing and segmentation [*atroposN4*]  
