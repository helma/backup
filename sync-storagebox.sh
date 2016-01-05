#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DATE=`date +%Y-%m-%dT%H:%M:%S`
export BORG_PASSPHRASE=`cat $SCRIPTPATH/.pwd`
START=$(date +%s.%N)
if mountpoint -q /mnt/storagebox; then
  START=$(date +%s.%N)
  rsync -rltzuv --delete /mnt/sda1/backup/ /mnt/storagebox/
  END=$(date +%s.%N)
  DIFF=$(echo "$END - $START" | bc)
  echo "rsync: $DIFF"
fi
