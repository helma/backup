#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

SERVER=root@naspi

MIRROR=/mnt/sda1/mirror
BACKUP=/mnt/sda1/backup

if [ "$#" -eq 0 ]; then # full backup
  NAME=$(hostname)
else
  NAME=$(basename "$1")
fi

MIRROR_PATH=$SERVER:$MIRROR/$NAME/
PWD=`cat $SCRIPTPATH/.pwd`

if pidof rsync; then # rsync running
  echo "rsync is already running"
else
  if [ -n "$(ping -c1 -W1 naspi)" ]; then # nas available
    ssh root@naspi "mkdir -p $MIRROR_PATH"
    if [ "$#" -eq 0 ]; then # full backup
      #https://wiki.archlinux.org/index.php/Full_system_backup_with_rsync
      rsync -aHSv --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /* $MIRROR_PATH
    elif [[ ( -e "$1" ) && ( -n "$(ls -A $1)" ) && ( "$1" =~ ^/media/ ) ]]; then # /media/* directory exists and is not empty
      # TODO add exclude for pis
      rsync -aHS --delete $1/* $MIRROR_PATH
    fi
    DATE=`date +%Y-%m-%dT%H:%M:%S`
    ssh root@naspi "export BORG_PASSPHRASE=$PWD; nohup borg create --stats --exclude-caches --compression zlib $BACKUP::$NAME-$DATE $MIRROR/$NAME >> /tmp/borg.log 2>&1 &"
  fi
fi
