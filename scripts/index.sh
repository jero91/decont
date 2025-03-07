# This script should index the genome file specified in the first argument,
# creating the index in a directory specified by the second argument.

# The STAR command is provided for you. You should replace the parts surrounded by "<>" and uncomment it.
mkdir $2
 STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $2 --genomeFastaFiles $1 --genomeSAindexNbases 9 >> log/index.log
