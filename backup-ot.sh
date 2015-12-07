#!/bin/sh

rsync -av --delete --delete-excluded --inplace --exclude bak/ /media/ot/ /home/ch/Dropbox/ot/
#rsync -av --delete --delete-excluded --inplace --exclude bak/ /home/ch/Dropbox/ot/ /backup/ot/
#sleep 2
# snapshot
#sudo zfs snapshot "backup/ot@`date +"%Y-%m-%d %T"`"
