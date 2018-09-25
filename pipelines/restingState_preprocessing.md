# Resting State fMRI Preprocessing Pipeline
7. Bias field correction  
  a. T1/T2 debiasing [*stupid text*]  
  b. N4 debiasing [*T1 only acquisition*]  
  c. Iterative N4 debiasing and segmentation [*atroposN4*] 
  c. funstuff [*stupidstuff*]
1. DICOM conversion to NIfTI
  a. Assumes that anat (*T1*) to atlas (*standard*) transforms already exist
  b. Create anat to standard transforms if missing (*2x2x2, 3x3x3 space?*)
  c. Allow for multiple standard atlas transforms
    - MNI152
    - MNI 2009c
    - CIT168
    - HCP S1200
    - Koscik HCP
3. Motion correction (*e.g. https://stnava.github.io/fMRIANTs , https://github.com/ANTsX/ANTsR/blob/master/R/preprocessfMRI.R#L44-L46*)
