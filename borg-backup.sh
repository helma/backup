#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DATE=`date +%Y-%m-%dT%H:%M:%S`
export BORG_PASSPHRASE=`cat $SCRIPTPATH/.pwd`
START=$(date +%s.%N)
if mountpoint -q /mnt/sda1; then
  borg create -v --stats --exclude-caches --compression zlib /mnt/sda1/backup::mpc-$DATE /mnt/sda1/mirror/mpc
  END=$(date +%s.%N)
  DIFF=$(echo "$END - $START" | bc)
  echo "borg: $DIFF"
fi
