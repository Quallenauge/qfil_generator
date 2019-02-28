#!/bin/bash

DISC_DUMP=$1
OUTPUT_FOLDER=out

if [ -z "$DISC_DUMP" ]; then
 echo "Usage: $0 <path to mmcblk0>"
 exit -1
fi

rm -rf $OUTPUT_FOLDER

python2 GPTAnalyzer.py /storage/media/Downloads/Android/bq_aquaris_X_pro/backup/DevPhone/mmcblk0 >/tmp/partition0.xml
python2 GPTParserTool.py -x /tmp/partition0.xml -v9 --location $OUTPUT_FOLDER
