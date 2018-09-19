#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: convert_sbv2txt.sh xxx.sbv yyy.txt"
  exit 1
fi

INFILE=$1
OUTFILE=$2

# Change CR/LF to LF
cat ${INFILE} | sed -e 's/\r//' > temp.txt
INFILE=temp.txt

TXT_X=""
TXT_Y=""

while read TEXT
do
  if [ "${TEXT}" == "" ]; then
    echo -e -n "${TXT_X} ${TXT_Y}" >> ${OUTFILE}
    TXT_X=""
    TXT_Y=""
  elif [ "x${TXT_X}y" == "xy" ]; then
    TXT_X=`echo "${TEXT}" | cut -d. -f1`
  else
    TXT_Y="${TXT_Y}${TEXT}\n"
  fi
done < ${INFILE}

rm -f temp.txt
