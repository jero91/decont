# This script should merge all files from a given sample (the sample id is provided in the third argument)
# into a single file, which should be stored in the output directory specified by the second argument.
# The directory containing the samples is indicated by the first argument.
echo $1
echo $2
echo $3
contador=1
for i in $(find data -name "*$3*tq")
do 
	documento$contador=`$i`
	contador=$contador+1
done
#cat file1.tar.gz file2.tar.gz > merged.tar.gz
echo $documento1
