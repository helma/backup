#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if pidof rsync; then # nas available
  echo "rsync is already running"
else
  if [ -n "$(ping -c1 -W1 naspi)" ]; then # nas available
    if [ "$#" -eq 0 ]; then # full backup
      #https://wiki.archlinux.org/index.php/Full_system_backup_with_rsync
      sudo rsync -aHSv --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /* root@naspi:/mnt/sda1/mirror/`hostname`/
    elif [[ ( -e "$1" ) && ( -n "$(ls -A $1)" ) && ( "$1" =~ ^/media/ ) ]]; then # /media/* directory exists and is not empty
      # TODO add exclude for pis
      sudo ssh root@naspi "mkdir -p /mnt/sda1/mirror/`basename "$1"`/"
      sudo rsync -aHSv --delete $1/* root@naspi:/mnt/sda1/mirror/`basename "$1"`/
    fi
  fi
fi
