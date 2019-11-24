
#Download all the files specified in data/filenames
#for url in $(cat data/urls) #TODO
#do
#    bash scripts/download.sh $url data
#done

#Sustituyo el for por una linea wget comprobando que exista
if [ -e data/$(basename $(head -n 1 data/urls)) ]; 
then 
    echo "--------------------------The sample files Exists-----------------------------------------"
else
    echo "--------------------------The sample file is not present---------------------------------"
    wget -P data/ $(cat data/urls)
fi

# Download the contaminants fasta file, and uncompress it
if [ -e res/contaminants.fasta.gz ]; 
then 
    echo "--------------------------The contaminants file Exists-----------------------------------------"
else
    echo "--------------------------The contaminants file is not present---------------------------------"
    bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res #TODO
fi

# Index the contaminants file
if [ -e res/contaminants_idx ]; 
then 
    echo "--------------------------The index file Exists-----------------------------------------"
else
    echo "--------------------------The index file is not present---------------------------------"
    bash scripts/index.sh res/contaminants.fasta res/contaminants_idx
fi


# Merge the samples into a single file
if [ -e out/merged ]; 
then 
    echo "--------------------------The merged file Exists-----------------------------------------"
else
    echo "--------------------------The merged file is not present---------------------------------"
	mkdir -p out/merged
	for sid in $(ls data/*.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq) #TODO
        	do
   		bash scripts/merge_fastqs.sh data out/merged $sid
		done
fi


# TODO: run cutadapt for all merged files

if [ -e out/trimmed ]; 
then 
    echo "--------------------------The trimmed file Exists-----------------------------------------"
else
    echo "--------------------------The trimmed file is not present---------------------------------"
	mkdir -p log/cutadapt
	mkdir -p out/trimmed
	for sid in $(ls data/*.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
	do
		cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed -o out/trimmed/$sid.fastq.gz  $(ls out/merged/$sid*) >> log/cutadapt/$sid.log
	done
fi



#TODO: run STAR for all trimmed files
if [ -e out/star ]; 
then 
    echo "--------------------------The star file Exists-----------------------------------------"
else
    echo "--------------------------The star file is not present---------------------------------"
	mkdir -p out/star
	for fname in out/trimmed/*.fastq.gz
	do
         # you will need to obtain the sample ID from the filename
        sid=$(basename $fname .fastq.gz)
        mkdir -p out/star/$sid
        STAR --runThreadN 4 --genomeDir res/contaminants_idx --outReadsUnmapped Fastx --readFilesIn out/trimmed/$sid* --readFilesCommand zcat --outFileNamePrefix out/star/$sid/ >> log/pipeline.log
done 
fi



# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
