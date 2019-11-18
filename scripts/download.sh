# This script should download the file specified in the first argument ($1), place it in the directory specified in the second argument, 
# and *optionally* uncompress the downloaded file with gunzip if the third argument contains the word "yes".
echo "Entrando en download"
#echo $1
nombre=`basename $1 .tar.gz`
#echo $nombre
#echo ${nombre:51:22}
wget -O /home/user02/Desktop/examenLinux/decont/$2/$nombre $1
gunzip -k /home/user02/Desktop/examenLinux/decont/$2/$nombre

