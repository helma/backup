#!/bin/sh

# general
rsync -av --delete --delete-excluded --inplace --exclude-from=$HOME/.backup_exclude /home/ch /backup/`hostname`/home/
# archive
#rsync -av --inplace /home/ch/archive /backup/`hostname`/home/ch/
#rm -rf /home/ch/archive
#mkdir /home/ch/archive
# snapshot
sudo zfs snapshot "backup/zx81@`date +"%Y-%m-%d %T"`"
# cleanup
#/home/ch/src/backup/cleanup.rb
# backup mail
#rsync -av --inplace --exclude INBOX --exclude .notmuch /backup/`hostname`/home/ch/mail/ /backup/pim/mail/ && /home/ch/bin/trash `/usr/bin/notmuch search --output=files $(date +%s -d 2009-10-01)..$(date +%s -d "6 month ago")`
