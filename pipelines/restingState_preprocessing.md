# Resting State fMRI Preprocessing Pipeline
1. DICOM conversion to NIfTI
  a. Assumes that anat [*T1*] to atlas [*standard*] transforms already exist
  b. Create anat to standard transforms if missing [*2mm or 3mm space*]
  c. Allow for multiple standard atlas transforms
    - MNI152
    - MNI 2009c
    - CIT168
    - HCP S1200
    - Koscik HCP
7. Bias field correction  
  a. T1/T2 debiasing [*T1 and T2 co-acquisition*]  
  b. N4 debiasing [*T1 only acquisition*]  
  c. Iterative N4 debiasing and segmentation [*atroposN4*]
7. DICOM conversion to NIfTI 
  a. Assumes that anat [*T1*] to atlas [*standard*] transforms already exist
  b. N4 debiasing [*T1 only acquisition*]  
  c. Iterative N4 debiasing and segmentation [*atroposN4*]  
