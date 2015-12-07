#!/bin/sh

rsync -av --delete --inplace /media/op1/ /home/ch/Dropbox/op1/
# snapshot
#ssh $server "sudo zfs snapshot backup/lxr@\"`date +\"%Y-%m-%d %T\"`\""
