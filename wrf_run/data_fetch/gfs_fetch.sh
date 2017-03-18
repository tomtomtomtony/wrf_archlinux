#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-06 19:18:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-03-18 09:34:47

# This script loads the required input data for a 180 h forecast run
# $1 matches the required date yyyymmdd
# $2 matches the required timestamp
# $3 is the storage path

# Remove old files
rm $3/gfs.*

# Fetch the new ones
for i in $(seq -f %03g 0 3 180); do
wget -P $3 http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/gfs.$1$2/gfs.t$2z.pgrb2.0p50.f$i
done
