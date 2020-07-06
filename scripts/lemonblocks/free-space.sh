#!/bin/bash

diskusage=$(df -h | grep /dev/sd | awk '{ print $1 " " $4 }' | tr '\n' ' ')

printf "[$diskusage]"
