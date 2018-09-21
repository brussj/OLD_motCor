for D in /Shared/nopoulos/structural/DM1_MR/[0-9]*/[0-9]*/ANONRAW ; do 
T1=`find $D -name \*_T1_[A-Z][A-Z][A-Z].nii.gz`
T2=`find $D -name \*_T2_[A-Z][A-Z][A-Z].nii.gz`
FL=`find $D -name \*_FLAIR.nii.gz`
info=(`echo $D | awk '{gsub("/"," "); print $0}'`)
if [ "$FL" == "" ] ; then
printf \"DM1\",\"${info[4]}\",\"${info[5]}\",\"\{\'T1-30\'\:\[\'$T1\'\]\,\'T2-30\'\:\[\'$T2\'\]\}\"'\n'
else
   printf \"DM1\",\"${info[4]}\",\"${info[5]}\",\"\{\'T1-30\'\:\[\'$T1\'\]\,\'T2-30\'\:\[\'$T2\'\],\'FL-30\'\:\[\'$FL\'\]\}\"'\n'
fi
done > /nopoulos/structural/DM1_MR/BAWEXPERIMENT_20170302/BAWEXPERIMENT_20170302.csv

