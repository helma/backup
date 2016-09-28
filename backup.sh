#!/bin/sh

# mount
mkdir -p /mnt/backup
mkdir -p /mnt/storagebox
mount -U 1632b2b3-bfbb-48a9-b417-05bcdbb41e63 /mnt/backup
sshfs u116373@u116373.your-storagebox.de: /mnt/storagebox

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
BACKUP=/mnt/backup/backup
NAME=$(hostname)
DATE=`date +%Y-%m-%dT%H:%M:%S`
export BORG_PASSPHRASE=`cat $SCRIPTPATH/.pwd`

# backup
borg create --debug --progress --stats --exclude-caches --compression zlib  --exclude-from $SCRIPTPATH/exclude $BACKUP::$NAME-$DATE /* 

# sync to storagebox
rsync -rltzuv --delete /mnt/backup/backup/ /mnt/storagebox/

umount /mnt/backup
rmdir /mnt/backup
umount /mnt/storagebox
rmdir /mnt/storagebox
