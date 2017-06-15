#!/bin/sh
# @Author: Benjamin Held
# @Date:   2017-03-15 18:22:35
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2017-06-15 22:24:09

# define terminal colors
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ "$#" -ne 4 ]; then # no argument, run whole script
  echo "Wrong number of arguments. Must be one for <YEAR> <MONTH> <DAY> <HOUR>."
  exit 1
fi

# Setting start conditions
START_YEAR=$1
START_MONTH=$2
START_DAY=$3
START_HOUR=$4

END_HOUR=`date '+%H' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +180 hours"`
END_YEAR=`date '+%Y' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +180 hours"`
END_MONTH=`date '+%m' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +180 hours"`
END_DAY=`date '+%d' -u -d "${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR} +180 hours"`

DT=90
DX=10000
DY=10000

GRID_X=300
GRID_Y=300

printf "${YELLOW}\nSetting start date to: ${START_YEAR}-${START_MONTH}-${START_DAY} ${START_HOUR}:00${NC}\n"
printf "${YELLOW}\nSetting end date to: ${END_YEAR}-${END_MONTH}-${END_DAY} ${END_HOUR}:00${NC}\n"
printf "${YELLOW}\nSetting grid to $GRID_X x $GRID_Y${NC}\n"
printf "${YELLOW}\nSetting step size to $DX x $DY${NC}\n"
printf "${YELLOW}\nSetting time step $DT${NC}\n"

# Adjust values in namelist.wps in the wps folder
cd ${HOME}/Build_WRF/WPS
sed -r -i "s/start_date = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/start_date = '${START_YEAR}\-${START_MONTH}\-${START_DAY}\_${START_HOUR}/g" namelist.wps
sed -r -i "s/end_date   = '[0-9]+\-[0-9]+\-[0-9]+\_[0-9]+/end_date   = '${END_YEAR}\-${END_MONTH}\-${END_DAY}\_${END_HOUR}/g" namelist.wps

sed -r -i "s/e\_we              =  [0-9]+/e\_we              =  ${GRID_X}/g" namelist.wps
sed -r -i "s/e\_sn              =  [0-9]+/e\_sn              =  ${GRID_Y}/g" namelist.wps

sed -r -i "s/dx = [0-9]+/dx = ${DX}/g" namelist.wps
sed -r -i "s/dy = [0-9]+/dy = ${DY}/g" namelist.wps

# Adjust values in namelist.input in the wrf folder
cd ${HOME}/Build_WRF/WRFV3/test/em_real
sed -r -i "s/start_year                          = [0-9]+/start_year                          = ${START_YEAR}/g" namelist.input
sed -r -i "s/start_month                         = [0-9]+/start_month                         = ${START_MONTH}/g" namelist.input
sed -r -i "s/start_day                           = [0-9]+/start_day                           = ${START_DAY}/g" namelist.input
sed -r -i "s/start_hour                          = [0-9]+/start_hour                          = ${START_HOUR}/g" namelist.input

sed -r -i "s/end_year                            = [0-9]+/end_year                            = ${END_YEAR}/g" namelist.input
sed -r -i "s/end_month                           = [0-9]+/end_month                           = ${END_MONTH}/g" namelist.input
sed -r -i "s/end_day                             = [0-9]+/end_day                             = ${END_DAY}/g" namelist.input
sed -r -i "s/end_hour                            = [0-9]+/end_hour                            = ${END_HOUR}/g" namelist.input

sed -r -i "s/e\_we                                = [0-9]+/e\_we                                = ${GRID_X}/g" namelist.input
sed -r -i "s/e\_sn                                = [0-9]+/e\_sn                                = ${GRID_Y}/g" namelist.input

sed -r -i "s/time_step                           = [0-9]+/time_step                           = ${DT}/g" namelist.input
sed -r -i "s/dx                                  = [0-9]+/dx                                  = ${DX}/g" namelist.input
sed -r -i "s/dy                                  = [0-9]+/dy                                  = ${DY}/g" namelist.input
