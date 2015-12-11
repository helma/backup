#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ -n "$(ping -c1 -W1 router)" ]; then # router available
  if [ "$#" -eq 0 ]; then # full backup
    #https://wiki.archlinux.org/index.php/Full_system_backup_with_rsync
    sudo rsync -aHSv --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /* admin@router:/mnt/sda1/mirror/`hostname`/
  elif [[ ( -e "$1" ) && ( -n "$(ls -A $1)" ) && ( "$1" =~ ^/media/ ) ]]; then # directory exists and is not empty
    # TODO add exclude for pis
    sudo rsync -aHSv --delete "$1/*" admin@router:/mnt/sda1/mirror/`basename "$1"`/
  fi
fi
