#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DATE=`date +%Y-%m-%dT%H:%M:%S`
export BORG_PASSPHRASE=`cat $SCRIPTPATH/.pwd`
START=$(date +%s.%N)
if mountpoint -q /mnt/sda1; then
  borg create -v --dry-run --stats --exclude-caches --exclude-from $SCRIPTPATH/exclude --compression zlib /mnt/sda1/backup::`hostname`-$DATE /
  END=$(date +%s.%N)
  DIFF=$(echo "$END - $START" | bc)
  echo "borg: $DIFF"
fi
