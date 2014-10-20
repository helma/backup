#!/bin/sh

server=192.168.0.100

if ping -i 5 -w 5 $server; then
  name=`ssh $server "hostname"`
  if [ $name == 'hpmini' ]; then
    rsync -av --delete --delete-excluded --inplace --exclude bak/ /media/ot/ $server:/backup/ot/
    # snapshot
    ssh $server "sudo zfs snapshot backup/ot@\"`date +\"%Y-%m-%d %T\"`\""
  fi
fi
