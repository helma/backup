#!/bin/sh

server=192.168.0.100

name=`ssh $server "hostname"`
if [ $name == 'hpmini' ]; then
  sudo dd if=/dev/sdb | xz | ssh $server "dd of=/backup/pi/arch.img.xz"
  # snapshot
  ssh $server "sudo zfs snapshot backup/pi@\"`date +\"%Y-%m-%d %T\"`\""
fi
