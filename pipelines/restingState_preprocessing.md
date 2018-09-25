# Resting State fMRI Preprocessing Pipeline

1. DICOM conversion to NIfTI
  a. Assumes that anat (T1) to atlas (standard) transforms already exist
  b. Create anat to standard transforms if missing (2x2x2, 3x3x3 space?)
  c. Allow for multiple standard atlas transforms
    1. MNI152
    2. MNI 2009c
    3. CIT168
    4. HCP S1200
    5. Koscik HCP
2. Reorient to RPI/LPI
3. Motion correction (e.g. https://stnava.github.io/fMRIANTs , https://github.com/ANTsX/ANTsR/blob/master/R/preprocessfMRI.R#L44-L46)
  a. 3dvolreg (AFNI)
  b. mcflirt (FSL)
  c. antsMotionCorr (ANTs)
    1. affine or affine & deformable correction
      a. Average the time series (for registration)
      b. Might be possible to do both in one step (-o [outputTransformPrefix,<outputWarpedImage>,<outputAverageImage>])
    2. Target scan of average volume or halway point?
      a. average the time series with antsMotionCorr, and align to that (then optionally update average and correct again)
    3. Average of motion corrected TRs
    4. Output motion parameters for regression?
    5. Mask creation of average motion corrected volume
4. Distortion Correction
  a. Prepping of fieldMap (fsl_prepare_fieldmap)
  b. blip-up/blip-down (topup and eddy) -- b0
    1. Is there a way to get topup warps into ANTs compatible files?)
      a. Perform topup, use as target, ANTs registration from motion corrected average to b0 corrected volume
    2. Mask creation of b0 (corrected)
    3. b0 to anat registration
5. Summation of transforms
  a. anat to atlas (I.)
  b. b0 to anat (III.)
  c. func (avg) to b0 (IV.)
6. Push data to standard space
  a. Multi-region segmentation
    1. Cortex, Insula, Thalamus, Basal Ganglia, Cerebellum, Brainstem and Pons
      a. In atlas space
      b. Joint Label Fusion per anat, pushed to standard
  b. Tissue Class segmentation
    1. anat, pushed to standard
  c. Skull-stripping
7. Smoothing
  a. Per region, differentially (e.g. STN < Cortex)
    1. SUSAN (FSL)
    2. 3dBlurToFWHM (AFNI)
    3. SmoothImage (ANTs)
8. Nuisance regression
  a. Motion parameters
    1. Bandpass these same as func (1dBandpass)
  b. WM, CSF
    1. Model the timecourse from an ROI (e.g. FEAT)
    2. CompCor
  c. Global signal
    1. Positive and Negative correlations, ~mean centered
  d. ICA-based removal of noise
    1. melodic & fsl_regfilt
    2. ICA-AROMA
  e. Filtering
    1. Lowpass filter (retain "high" frequencies)
    2. Bandpass filter
      a. 0.008 to 0.8 HZ
      b. 0.009 to 0.1 Hz
      c. 0.01 to 0.1 Hz
9.  Motion scrubbing
10. Concatenate multiple runs
  a. Normalize final file
    1. subtract mean, divide by standard deviation, add value 1000 (timecourse will be centered around 1000)
11.  Celebrate life, drink a beer
