#!/bin/bash

echo ""
echo "#==========================================#"
echo "| Server Performance Stats shell script    |"
echo "| As per roadmap.sh instructions at:       |"
echo "| https://roadmap.sh/projects/server-stats |"
echo "#==========================================#"

echo ""

VMSTAT_OUTPUT="$(vmstat -S M | awk 'NR>2 {print $3} NR>2 {print $4} NR>2 {print $5} NR>2 {print $6} NR>2 {print $13}')"
DISK_USAGE="$(df -h | grep /dev/sda1)"

echo "Total CPU Usage: $(echo $VMSTAT_OUTPUT | awk '{print $5}')%"
echo ""

echo "Memory used: $(echo $VMSTAT_OUTPUT | awk 'sum=$1+$3+$4 {print sum}')M \
    $(echo $VMSTAT_OUTPUT | awk 'sum=(100*($1+$3+$4)/($1+$2+$3+$4))  {print sum}')%"
echo "Memory free: $(echo $VMSTAT_OUTPUT | awk '{print $2}')M \
    $(echo $VMSTAT_OUTPUT | awk 'sum=(100*$2/($1+$2+$3+$4)) {print sum}')%"
echo ""

echo "Disk space used: $(echo $DISK_USAGE | awk '{print $3, 0+$5}')%"
echo "Disk space free: $(echo $DISK_USAGE | awk '{print $4, 100-$5}')%"
echo ""
echo "Top 5 processes by CPU utilisation:"
echo "$(top -b -n 1 -o %CPU | tail -n+7 | head -n 6)"
echo ""
echo "Top 5 processes by memory utilisation:"
echo "$(top -b -n 1 -o %MEM | tail -n+7 | head -n 6)"


