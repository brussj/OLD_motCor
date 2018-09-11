# Data Structure Specifications
## Iowa Imaging Data Science Core

Author: Timothy R. Koscik, PhD
Date:   September 11, 2018

## Key:
```
[] = optional, ()=example, {}=variable
${ursi}=subject identifier
${mrqid}=session identifier
```
# Data Structure
```
${researcherRoot}/
      ∟${projectName}/
          ∟dicom/			Read-only archive
          |	  ∟sub-${ursi}_ses-${mrqid}.zip
          ∟nifti/			Read-only archive
          |	  ∟${ursi}/
          |		    ∟${mrqid}/
          |			      ∟anat/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_${mod}.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_${mod}.nii.gz
          |			      ∟dwi/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_dwi.bval
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_dwi.bvec
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_dwi.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_dwi.nii.gz
          |			      ∟fmap/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_magnitude.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_magnitude.nii.gz
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_phase.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_phase.nii.gz
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_spinecho_pe-AP.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_spinecho_pe-AP.nii.gz
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_spinecho_pe-PA.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_spinecho_pe-PA.nii.gz
          |			      ∟func/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_bold.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_bold.nii.gz
          |			      ∟mrs/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_mrs_roi-${roi}.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_mrs_roi-${roi}.p
          |			      ∟other/
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_${mod}.json
          |			      |	  ∟sub-${ursi}_ses-${mrqid}_${mod}.nii.gz
          |			      ∟qa/
          |				        ∟sub-${ursi}_ses-${mrqid}_qa_acq-${acq}.json
          |				        ∟sub-${ursi}_ses-${mrqid}_qa_acq-${acq}.nii.gz
          ∟deriv/
          |	  ∟anat/
          |	  |	  ∟native/
          |	  |	  |	  ∟sub-${ursi}_ses-${mrqid}_${mod}[_pre-${order}-${proc}].nii.gz
          |	  |	  |	  ∟sub-${ursi}_ses-${mrqid}_${mod}[_mask-${roi}].nii.gz
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-01-acpc.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-02-dn.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-03-bc.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-04-bex.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-05-seg_class-csf.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-05-seg_class-gm.nii.gz)
          |	  |	  |	  ∟(sub-1234_ses-123456_T1w_pre-05-seg_class-wm.nii.gz)
          |	  |	  ∟reg_[${space}]/ (e.g. mni, etc. [accompanying transforms in tform folder])
          |	  ∟b2/				(Brains2; legacy support only)
          |	  ∟baw/				(BrainsAutoWorkup)
          |	  ∟dwi/
          |	  ∟fsurf/			(Freesurfer)
          |	  ∟func/
          |	  |	  ∟ts/
          |	  |	  |	  ∟sub-${ursi}_ses-${mrqid}_task-${task}_[_pre-${order}-${proc}].nii.gz
          |	  |	  ∟stb/
          |	  ∟mrs/
          |	  ∟tform/
          |	  ∟qc/
          |	      ∟version_log/
          ∟scripts
          |	  ∟dicom_idx
          |	  |	  ∟master_dicom-idx.tsv
          |	  |	  |	- have a master for each study, copy and make changes for each subject
          |	  |	  ∟sub-${ursi}_ses-${mrqid}_dicom-idx.tsv (tab-separated)
          |	  |		  - column 1: scan directory inside zip file, e.g. /SCAN/1/DICOM,
          |	  |		  - column 2: destination folder: anat, dwi, fmap, func, mrs, other, qa
          |	  |		  - column 3: field name, e.g., mod, acq, task, roi, rec, run, echo, etc
          |	  |		  - column 4: field value, e.g., [${mod}] T1w, [${task}] rest, etc.
          ∟summary
              ∟${projectName}_${data_description}_${YYYYMMDD}.csv
              ∟(DM1_bt-volumetrics-wb_20180831.csv)
              ∟(DM1_fsurf-volumetrics-all_20180831.csv)
```

# Filename Fields (and order)
```
anat/
sub-${ursi}_ses-${mrqid}_${mod}[_acq-${acq}][_run-${#}][_echo-${#}]
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
