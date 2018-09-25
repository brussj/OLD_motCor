# Data Structure Specifications
## Iowa Imaging Data Science Core

Author: Timothy R. Koscik, PhD
Date:   September 25, 2018

## Key:
```
[] = optional, ()=example, {}=variable
${subject} = subject identifier
${session} = session identifier -> YYMMDDHHMM
${site} = site/scanner identifier -> ##### 
https://github.com/TKoscik/nimg_core/blob/master/lut/site_scanner.tsv

```
# Data Structure
```
${researcherRoot}/
    ∟${projectName}/
        ∟participants.tsv
        ∟dicom/			Read-only archive
        |    ∟sub-${subject}_ses-${mrqid}_site-${site}.zip
        ∟nifti/			Read-only archive
        |     ∟${subject}/
        |         ∟${session}/
        |              ∟anat/
        |              |    ∟sub-${subject}_ses-${session}_acq-${acq}[_run-${run}]_${mod}.json
        |              |    ∟sub-${subject}_ses-${session}_acq-${acq}[_run-${run}]_${mod}.nii.gz
        |              ∟dwi/
        |              |    ∟sub-${subject}_ses-${session}_dwi.bval
        |              |    ∟sub-${subject}_ses-${session}_dwi.bvec
        |              |    ∟sub-${subject}_ses-${session}_dwi.json
        |              |    ∟sub-${subject}_ses-${session}_dwi.nii.gz
        |              ∟fmap/
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_magnitude.json
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_magnitude.nii.gz
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_phase.json
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_phase.nii.gz
        |              |    ∟sub-${subject}_ses-${session}_spinecho_pe-AP.json
        |              |    ∟sub-${subject}_ses-${session}_spinecho_pe-AP.nii.gz
        |              |    ∟sub-${subject}_ses-${session}_spinecho_pe-PA.json
        |              |    ∟sub-${subject}_ses-${session}_spinecho_pe-PA.nii.gz
        |              ∟func/
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_run-${run}_bold.json
        |              |    ∟sub-${subject}_ses-${session}_task-${task}_run-${run}_bold.nii.gz
        |              ∟mrs/
        |              |    ∟sub-${subject}_ses-${session}_mrs_roi-${roi}.json
        |              |    ∟sub-${subject}_ses-${session}_mrs_roi-${roi}.p
        |              ∟other/
        |              |    ∟sub-${subject}_ses-${session}_${mod}.json
        |              |    ∟sub-${subject}_ses-${session}_${mod}.nii.gz
        |              ∟qa/
        |                   ∟sub-${subject}_ses-${session}_qa_acq-${acq}.json
        |                   ∟sub-${subject}_ses-${session}_qa_acq-${acq}.nii.gz
        ∟derivatives/
        |    ∟anat/
        |    |    ∟native/
        |    |    |    ∟sub-${subject}_ses-${session}_${mod}[_pre-${order}-${proc}].nii.gz
        |    |    |    ∟sub-${subject}_ses-${session}_${mod}[_mask-${roi}].nii.gz
        |    |    ∟prep/
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-acpc.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-avg.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-bex0.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-bex.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-bc.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-bias.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-denoise.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-gradunwarp.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-readout.nii.gz
        |    |    |   ∟sub-${subject}_ses-${session}_acq-${acq}_${mod}_prep-seg?.nii.gz
        |    |    ∟reg_[${space}]/ (e.g. mni, etc. [accompanying transforms in tform folder])
        |    ∟b2/  (Brains2; legacy support only)
        |    ∟baw/  (BrainsAutoWorkup)
        |    ∟dwi/
        |    ∟fsurf/ (Freesurfer subject directory)
        |    ∟func/
        |    |    ∟ts/
        |    |    |    ∟sub-${ursi}_ses-${mrqid}_task-${task}_[_pre-${order}-${proc}].nii.gz
        |    |    ∟stb/
        |    ∟mrs/
        |    ∟tform/
        |    ∟qc/
        |    ∟log/
        ∟code
        ∟lut
        ∟stimuli
        ∟summary
             ∟${projectName}_${data_description}_${YYYYMMDD}.csv
             ∟(DM1_bt-volumetrics-wb_20180831.csv)
             ∟(DM1_fsurf-volumetrics-all_20180831.csv)
```

# Filename Fields (and order)
```
anat/
sub-${ursi}_ses-${mrqid}_acq-${acq}[_run-${#}][_echo-${#}]_${mod}
mod=T1w|T2w|T1rho|T1map|T2map|T2star|FLAIR|FLASH|PD|PDT2|inplaneT1|inplaneT2|angio

dwi/
sub-${ursi}_ses-${mrqid}[_acq-${acq}][_b-${b}][_dir-${dir}][_pe-${pe}][_run-${#}]_dwi.nii.gz

func/
sub-${ursi}_ses-${mrqid}_task-${task}[_acq-${acq}][_pe-${pe}][_rec-${}][_run-${#}][_echo-${#}]_${mod}.nii.gz
mod=bold|T1rho
```

# Modality Labels - ${mod}
```
T1 weighted               T1w
T2 weighted               T2w
T1 rho                    T1rho
quantitative T1 map       T1map
quantitative T2 map       T2map
T2*/SWE                   T2star
FLAIR                     FLAIR
FLASH                     FLASH
Proton density            PD
Proton density map        PDmap
Combined PD/T2            PDT2
Inplane T1                inplaneT1	          T1-weighted matched to functional acquisition
Inplane T2                inplaneT2	          T2-weighted matched to functional acquisition
Angiography               angio
Spectroscopy              MRS
```
