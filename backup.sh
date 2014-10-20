#!/bin/sh

server=192.168.0.100

if ping -i 5 -w 5 $server; then
  name=`ssh $server "hostname"`
  if [ $name == 'hpmini' ]; then
    rsync -av --delete --inplace --exclude-from=$HOME/.backup_exclude /home/ch $server:/backup/`hostname`/home/
    # snapshot
    ssh $server "sudo zfs snapshot backup/zx81@\"`date +\"%Y-%m-%d %T\"`\""
    # backup mail
    ssh $server "rsync -av --inplace --exclude INBOX --exclude .notmuch /backup/`hostname`/home/ch/mail/ /backup/pim/mail/" && /home/ch/bin/trash `/usr/bin/notmuch search --output=files $(date +%s -d 2009-10-01)..$(date +%s -d "6 month ago")`
    # sync contacts
    cd ~/Contacts
    git pull
    git push
    # sync calendar
    # sync images
  fi
fi
