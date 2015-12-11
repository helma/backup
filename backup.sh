#!/bin/sh
#https://wiki.archlinux.org/index.php/Full_system_backup_with_rsync
# general
#rsync -av --delete --delete-excluded --inplace --exclude-from=$HOME/.backup_exclude /home/ch /backup/`hostname`/home/
#sudo rsync -aAXv --delete --delete-excluded --exclude-from=$HOME/.backup_exclude /home /etc /media/nfs/mirror/`hostname`/
sudo rsync -aAHSv --delete --delete-excluded --exclude-from=$HOME/.backup_exclude /* /media/nfs/mirror/`hostname`/
#sudo rsync -aAXHSv --delete --delete-excluded --exclude-from=$HOME/.backup_exclude /* /media/nfs/mirror/`hostname`/
# archive
#rsync -av --inplace /home/ch/archive /backup/`hostname`/home/ch/
#rm -rf /home/ch/archive
#mkdir /home/ch/archive
# snapshot
#sudo zfs snapshot "backup/zx81@`date +"%Y-%m-%d %T"`"
# cleanup
#/home/ch/src/backup/cleanup.rb
# backup mail
#rsync -av --inplace --exclude INBOX --exclude .notmuch /backup/`hostname`/home/ch/mail/ /backup/pim/mail/ && /home/ch/bin/trash `/usr/bin/notmuch search --output=files $(date +%s -d 2009-10-01)..$(date +%s -d "6 month ago")`
