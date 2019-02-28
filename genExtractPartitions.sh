#!/bin/sh

## sfdisk -l -uS image-file
#Disk image-file: 0 cylinders, 0 heads, 0 sectors/track
#Warning: The partition table looks like it was made
#for C/H/S=*/255/32 (instead of 0/0/0).
#For this listing I'll assume that geometry.
#Units = sectors of 512 bytes, counting from 0
#Device Boot Start End #sectors Id System
#image-filep1 32 261119 261088 83 Linux
#image-filep2 261120 4267679 4006560 82 Linux swap / Solaris
#image-filep3 4267680 142253279 137985600 83 Linux
#image-filep4 0 - 0 0 Empty

#dd if=image-file of=partition3-file skip=4267680 count=137985600

#export FILENAME=mmcblk0.img
export FILENAME=$1
export OUT_FILE=extractPartitions.sh

if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Usage: $0 <mmcblk0.img>"
    exit -1
fi

echo "#!/bin/bash" | tee $OUT_FILE
echo "set -v" | tee -a $OUT_FILE
echo "export FILENAME=$FILENAME" | tee -a $OUT_FILE
echo "mkdir -p img" | tee -a $OUT_FILE
sgdisk -p $FILENAME | grep -o -E "^ *[0-9].*" | awk '{print "dd if=$FILENAME of=img/"$7" skip="$2" count="$3-$2+1}' | tee -a $OUT_FILE
chmod +x $OUT_FILE