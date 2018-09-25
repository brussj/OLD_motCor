# Resting State fMRI Preprocessing Pipeline

I. DICOM conversion to NIfTI
  A. Assumes that anat (T1) to atlas (standard) transforms already exist
  B. Create anat to standard transforms if missing (2x2x2, 3x3x3 space?)
  C. Allow for multiple standard atlas transforms
    1. MNI152
    2. MNI 2009c
    3. CIT168
    4. HCP S1200
    5. Koscik HCP
```
II. Reorient to RPI/LPI
```
III. Motion correction (e.g. https://stnava.github.io/fMRIANTs , https://github.com/ANTsX/ANTsR/blob/master/R/preprocessfMRI.R#L44-L46)
  A. 3dvolreg (AFNI)
  B. mcflirt (FSL)
  C. antsMotionCorr (ANTs)
    1. affine or affine & deformable correction
      a. Average the time series (for registration)
      b. Might be possible to do both in one step (-o [outputTransformPrefix,<outputWarpedImage>,<outputAverageImage>])
    2. Target scan of average volume or halway point?
      a. average the time series with antsMotionCorr, and align to that (then optionally update average and correct again)
    3. Average of motion corrected TRs
    4. Output motion parameters for regression?
    5. Mask creation of average motion corrected volume
```
IV. Distortion Correction
  A. Prepping of fieldMap (fsl_prepare_fieldmap)
  B. blip-up/blip-down (topup and eddy) -- b0
    1. Is there a way to get topup warps into ANTs compatible files?)
      a. Perform topup, use as target, ANTs registration from motion corrected average to b0 corrected volume
    2. Mask creation of b0 (corrected)
    3. b0 to anat registration
```
V. Summation of transforms
  A. anat to atlas (I.)
  B. b0 to anat (III.)
  C. func (avg) to b0 (IV.)
```
VI. Push data to standard space
  A. Multi-region segmentation
    1. Cortex, Insula, Thalamus, Basal Ganglia, Cerebellum, Brainstem and Pons
      a. In atlas space
      b. Joint Label Fusion per anat, pushed to standard
  B. Tissue Class segmentation
    1. anat, pushed to standard
  C. Skull-stripping
```
VII. Smoothing
  A. Per region, differentially (e.g. STN < Cortex)
    1. SUSAN (FSL)
    2. 3dBlurToFWHM (AFNI)
    3. SmoothImage (ANTs)
```
VIII. Nuisance regression
  A. Motion parameters
    1. Bandpass these same as func (1dBandpass)
  B. WM, CSF
    1. Model the timecourse from an ROI (e.g. FEAT)
    2. CompCor
  C. Global signal
    1. Positive and Negative correlations, ~mean centered
  D. ICA-based removal of noise
    1. melodic & fsl_regfilt
    2. ICA-AROMA
  E. Filtering
    1. Lowpass filter (retain "high" frequencies)
    2. Bandpass filter
      a. 0.008 to 0.8 HZ
      b. 0.009 to 0.1 Hz
      c. 0.01 to 0.1 Hz
```
IX.  Motion scrubbing
```
X. Concatenate multiple runs
  A. Normalize final file
    1. subtract mean, divide by standard deviation, add value 1000 (timecourse will be centered around 1000)
```
XI.  Celebrate life, drink a beer



