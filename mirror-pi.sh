#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ -n "$(ping -c1 -W1 router)" ]; then # router available
  pmount ${1}1 /media/pi-boot
  pmount ${1}5 /media/pi
  hostname=`cat /media/pi/etc/hostname`
  echo $hostname
  sudo ssh admin@router "mkdir -p /mnt/sda1/mirror/pi-$hostname"
  #http://sysmatt.blogspot.ch/2014/08/backup-restore-customize-and-clone-your.html
  sudo rsync -aHSv --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /media/pi/* admin@router:/mnt/sda1/mirror/pi-$hostname/
  sudo rsync -aHSv --delete --delete-excluded --exclude-from=$SCRIPTPATH/exclude /media/pi-boot/* admin@router:/mnt/sda1/mirror/pi-$hostname/boot/
  pumount ${1}1
  pumount ${1}5 
fi
