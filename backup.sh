#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DATE=`date +%Y-%m-%dT%H:%M:%S`
export BORG_PASSPHRASE=`cat $SCRIPTPATH/.pwd`
START=$(date +%s.%N)
if mountpoint -q /media/nfs; then
  #rsync -aHS --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /* /media/nfs/mirror/`hostname`/
  #END=$(date +%s.%N)
  #DIFF=$(echo "$END - $START" | bc)
  #echo "rsync: $DIFF"
  #START=$(date +%s.%N)
  borg create -v --stats --exclude-caches --exclude-from $SCRIPTPATH/exclude --compression zlib /media/nfs/backup::`hostname`-$DATE /
  END=$(date +%s.%N)
  DIFF=$(echo "$END - $START" | bc)
  echo "borg: $DIFF"
  if mountpoint -q /media/storagebox; then
    START=$(date +%s.%N)
    rsync -rltzu --delete /media/nfs/backup/ /media/storagebox/
    END=$(date +%s.%N)
    DIFF=$(echo "$END - $START" | bc)
    echo "rsync: $DIFF"
  fi
fi
