#!/bin/sh

rsync -av --delete --inplace /media/lxr/ /home/ch/Dropbox/lxr/
# snapshot
#ssh $server "sudo zfs snapshot backup/lxr@\"`date +\"%Y-%m-%d %T\"`\""
