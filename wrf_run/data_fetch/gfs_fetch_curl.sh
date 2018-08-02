#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-06 19:18:17
# @Last Modified by:   benjamin
# @Last Modified time: 2018-03-18 21:03:09

# This script loads the required input data for a 180 h forecast run
# $1 matches the required date yyyymmdd
# $2 matches the required timestamp
# $3 is the storage path
# $4 is the model resolution [0p25, 0p50, 1p00]
# $5 the time period for the model run

# logging time stamp
now=$(date +"%T")
printf "Starting gfs data fetch by removing old files at ${now}.\n" > ./log.info

# Remove old files
rm ${3}/gfs.*

printf "Starting gfs data fetching at ${now}.\n" > ./log.info
# Define a number of retries and try to download the files
for i in $(seq -f %03g 0 3 ${5}); do
  tries=5
  while [ $tries -gt 0 ] 
  do
    curl -C - -o ${3}/gfs.t${2}z.pgrb2.${4}.f${i} http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/gfs.${1}${2}/gfs.t${2}z.pgrb2.${4}.f${i}
    if [ $? -ne 56 ]
     then break
    fi
    let --tries
  done
done