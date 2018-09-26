# Resting State fMRI Preprocessing Pipeline  
* DICOM conversion to NIfTI  
  * Assumes that anat (*T1*) to atlas (*standard*) transforms already exist  
  * Create anat to standard transforms if missing (*2x2x2, 3x3x3 space?*)  
  * Allow for multiple standard atlas transforms  
    * MNI152  
    * MNI 2009c  
    * CIT168  
    * HCP S1200  
    * Koscik HCP  
* Reorient to RPI/LPI  
* Motion correction (*e.g. https://stnava.github.io/fMRIANTs , https://github.com/ANTsX/ANTsR/blob/master/R/preprocessfMRI.R#L44-L46*)  
  * 3dvolreg (*AFNI*)  
  * mcflirt (*FSL*)  
  * antsMotionCorr (*ANTs*)  
    * affine or affine & deformable correction  
      * Average the time series (*for registration*)  
      * Might be possible to do both in one step (*-o [outputTransformPrefix,<outputWarpedImage>,<outputAverageImage>]*)  
    * Target scan of average volume or halway point?  
      * Average the time series with antsMotionCorr, and align to that (*then optionally update average and correct again*)  
    * Average of motion corrected TRs  
    * Output motion parameters for regression?  
    * Mask creation of average motion corrected volume  
* Distortion Correction  
  * Prepping of fieldMap (*fsl_prepare_fieldmap*)  
  * blip-up/blip-down (*topup and eddy* (*b0*))  
    * Is there a way to get topup warps into ANTs compatible files?  
      * Perform topup, use as target, ANTs registration from motion corrected average to b0 corrected volume  
    * Mask creation of b0 (*corrected*)  
    * b0 to anat registration  
* Summation of transforms  
  * anat to atlas (*I.*)  
  * b0 to anat (*III.*)  
  * func (*avg*) to b0 (*IV.*)  
* Push data to standard space  
  * Multi-region segmentation  
    * Cortex, Insula, Thalamus, Basal Ganglia, Cerebellum, Brainstem and Pons  
      * In atlas space  
      * Joint Label Fusion per anat, pushed to standard  
  * Tissue Class segmentation  
    * anat, pushed to standard  
  * Skull-stripping  
* Smoothing  
  * Per region, differentially (*e.g. STN < Cortex*)  
    * SUSAN (*FSL*)  
    * 3dBlurToFWHM (*AFNI*)  
    * SmoothImage (*ANTs*)  
* Nuisance regression  
  * Motion parameters  
    * Bandpass these same as func (*1dBandpass*)  
  * WM, CSF  
    * Model the timecourse from an ROI (*e.g. FEAT*)  
    * CompCor  
  * Global signal  
    * Positive and Negative correlations (*~mean centered*)  
  * ICA-based removal of noise  
    * melodic & fsl_regfilt  
    * ICA-AROMA  
  * Filtering  
    * Lowpass filter (*retain "high" frequencies*)  
    * Bandpass filter  
      * 0.008 to 0.8 HZ  
      * 0.009 to 0.1 Hz  
      * 0.01 to 0.1 Hz  
* Motion scrubbing  
* Concatenate multiple runs  
  * Normalize final file  
    * subtract mean, divide by standard deviation, add value 1000 (*timecourse will be centered around 1000*)  
* Celebrate life, drink a beer  
 





# Misc  
![antsMotionParams](/nopoulos/forGithub/antsMotionCorrPlot_test.png)
