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
      * Average the time series (*for registration*)  
      * Might be possible to do both in one step (*-o [outputTransformPrefix,<outputWarpedImage>,<outputAverageImage>]*)  
    - Target scan of average volume or halway point?  
      * Average the time series with antsMotionCorr, and align to that (*then optionally update average and correct again*)  
    - Average of motion corrected TRs  
    - Output motion parameters for regression?  
    - Mask creation of average motion corrected volume  
4. Distortion Correction  
  a. Prepping of fieldMap (*fsl_prepare_fieldmap*)  
  b. blip-up/blip-down (*topup and eddy* (*b0*))  
    - Is there a way to get topup warps into ANTs compatible files?  
      * Perform topup, use as target, ANTs registration from motion corrected average to b0 corrected volume  
    - Mask creation of b0 (*corrected*)  
    - b0 to anat registration  
5. Summation of transforms  
  a. anat to atlas (*I.*)  
  b. b0 to anat (*III.*)  
  c. func (*avg*) to b0 (*IV.*)  
6. Push data to standard space  
  a. Multi-region segmentation  
    - Cortex, Insula, Thalamus, Basal Ganglia, Cerebellum, Brainstem and Pons  
      * In atlas space  
      * Joint Label Fusion per anat, pushed to standard
  b. Tissue Class segmentation  
    - anat, pushed to standard  
  c. Skull-stripping  
