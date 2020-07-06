#!/bin/bash

diskusage=$(df -h | grep /dev/sd | awk '{ print $1 " " $3 }' | sed 's/\n/; /g')

printf "[$diskusage]"
