# This script should merge all files from a given sample (the sample id is provided in the third argument)
# into a single file, which should be stored in the output directory specified by the second argument.
# The directory containing the samples is indicated by the first argument.

cat $(ls $1/*$3*.fastq.gz) > $2/$3merged.tar.gz
#gunzip -k $2/$3merged.tar.gz

#Star por defecto el log lo deja en log out y el cutadapt hay que ponerselo
#Poner condicional si es "Yes" entonces descomprim¿?. myvar=$(comando)!!!!!!
