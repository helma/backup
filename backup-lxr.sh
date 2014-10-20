#!/bin/sh

server=192.168.0.100

if ping -i 5 -w 5 $server; then
  name=`ssh $server "hostname"`
  if [ $name == 'hpmini' ]; then
    rsync -av --delete --inplace /media/lxr/ $server:/backup/lxr/
    # snapshot
    ssh $server "sudo zfs snapshot backup/lxr@\"`date +\"%Y-%m-%d %T\"`\""
  fi
fi
