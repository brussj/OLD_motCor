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
 




# fMRI Motion Correction  
 ## Background  
 some boring text  
 more boring text  
 even more boring text  
 ## antsMotionCorr (vs. 3dvolreg)  
 * More control over motion correction parameters (nonlinear over affine, more iterations, etc.)  
 * Ability to sum motion correction parameters into other registrations (EPI blip-up/blip-down, b0 to T1, T1 to MNI, etc.)  
 
 ### 3dvolreg (AFNI) vs. ANTs  
 * EPI run has 168 timepoints.  Use halway point as target for motion correction (but made a mistake and used 64, not 84)  
   * For testing, this won't matter.  For real-world, this would matter (kinda, sorta)  
 * For simplicity, used the collapsed average output from vanilla run of 3d volreg  
 * Ran the affine version for use with applying the motion correction to the data  
   * Could have calculated the motion parameter estimates (rotations and translations) from the Affine info but just re-ran with a rigid-body (6 paramter) version and logged the MOCO data
 
 ![afniAntsMotionCorrRaw](https://github.com/brussj/nimg_core/blob/master/pipelines/AFNI_ANTs_motParams_Raw.png)  
 
 * At first glance, everything looks wrong with antsMotionCorr.  
   * AFNi uses mm for translations, degrees for rotations, under the assumption that near the edge of the brain that 1 deg ~= 1mm.  ANTs appears to use radians.
   * Quickly converted between from radians to degrees via:
```  
Deg = Rad*180/3.14159  
```  
 * One problem solved  
  
 ![afniAntsMotionCorrDeg](https://github.com/brussj/nimg_core/blob/master/pipelines/AFNI_ANTs_motParams_ANTsDeg.png)  
 
 * Pulled apart the rotations and translations to visually compare one at a time  
 * It looks like AFNI and ANTs have a different order and a few differing directions  
 
 ![afniAntsMotionCorrSplit](https://github.com/brussj/nimg_core/blob/master/pipelines/AFNI_ANTs_RotationsTranslations_base.png)  

 * From the man page of 3dvolreg  
```  
The output is in 9 ASCII formatted columns:  
n  roll  pitch  yaw  dS  dL  dP  rmsold rmsnew  
```  
 * The orginal mapping to antsMotionCorr  
```
rot1 rot2 rot3 trans1 trans2 trans3  
```
 * The new mappign to antsMotionCorr to match 3dvolreg  
```
-rot3 -rot1 -rot2 trans3 trans1 -trans2  
```  

 ![afniAntsMotionCorrSplitReordered](https://github.com/brussj/nimg_core/blob/master/pipelines/AFNI_ANTs_RotationsTranslations_FlippedSwapped.png)  
 
 * Putting this all back together, antsMotionCorr and 3dvolreg look to be quite similar  
![afniAntsMotionCorrFinal](https://github.com/brussj/nimg_core/blob/master/pipelines/AFNI_ANTs_motParams_ANTsDeg_FlippedSwapped.png)  


 
 some stuff
![antsMotionCorrStats](https://github.com/brussj/nimg_core/blob/master/antsMotionCorrPlot_test.png)  
