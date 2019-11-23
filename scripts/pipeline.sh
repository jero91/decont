#Download all the files specified in data/filenames
#for url in $(cat /home/user02/Desktop/examenLinux/decont/data/urls) #TODO
#do
#    bash /home/user02/Desktop/examenLinux/decont/scripts/download.sh $url data
#done

# Download the contaminants fasta file, and uncompress it
#bash /home/user02/Desktop/examenLinux/decont/scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes #TODO

# Index the contaminants file
#bash /home/user02/Desktop/examenLinux/decont/scripts/index.sh res/contaminants.fasta res/contaminants_idx

# Merge the samples into a single file
#for sid in $(ls data/*.fastq | cut -d "_" -f1 | sed 's:data/::' | sort | uniq) #TODO
#do
#    bash scripts/merge_fastqs.sh data out/merged $sid
#done

# TODO: run cutadapt for all merged files
#for sid in $(ls data/*.fastq | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
#do
#	cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed -o out/trimmed/$sid.fastq.gz  $(ls out/merged/$sid*) #log/out/$sid¿?
#done

#TODO: run STAR for all trimmed files
for fname in out/trimmed/*.fastq.gz
do
    # you will need to obtain the sample ID from the filename
    sid=$(basename $fname .tar.gz)
    mkdir -p out/star/$sid
     STAR --runThreadN 4 --genomeDir res/contaminants_idx --outReadsUnmapped Fastx --readFilesIn out/trimmed/$sid --readFilesCommand zcat --outFileNamePrefix out/star/$sid
	echo $sid
done 

# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
