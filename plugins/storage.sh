#!/bin/bash

DISK_USAGE=$(df -H / | tail -1)

TOTAL=$(echo $DISK_USAGE | awk '{print $2}')
USED=$(echo $DISK_USAGE | awk '{print $3}')
AVAIL=$(echo $DISK_USAGE | awk '{print $4}')
USEP=$(echo $DISK_USAGE | awk '{print $5}' | sed 's/%//')

FREEP=$((100 - USEP))

sketchybar --set $NAME label="$FREEP%" icon="􀤂" icon.position=right