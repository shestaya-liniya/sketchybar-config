#!/bin/bash

PAGE_SIZE=$(sysctl -n hw.pagesize)
MEM_STATS=$(vm_stat)

FREE=$(echo "$MEM_STATS" | awk '/Pages free/ {print $3}' | sed 's/\.//')
INACTIVE=$(echo "$MEM_STATS" | awk '/Pages inactive/ {print $3}' | sed 's/\.//')
WIRED=$(echo "$MEM_STATS" | awk '/Pages wired down/ {print $4}' | sed 's/\.//')
ACTIVE=$(echo "$MEM_STATS" | awk '/Pages active/ {print $3}' | sed 's/\.//')
COMPRESSED=$(echo "$MEM_STATS" | awk '/Pages occupied by compressor/ {print $5}' | sed 's/\.//')

TOTAL=$(( (FREE + INACTIVE + ACTIVE + WIRED + COMPRESSED) * PAGE_SIZE ))
USED=$(( TOTAL - (FREE + INACTIVE) * PAGE_SIZE ))

RAM_PERCENT=$(( USED * 100 / TOTAL ))

sketchybar --set $NAME \
  label="$RAM_PERCENT%" \
  icon="􀫦" \
  icon.position=right \
  label.width=40
