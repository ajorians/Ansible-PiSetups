#!/bin/bash

DATE=`date +%F`
/home/ajorians/Documents/git/BackupScripts/Backdrop/RestoreBackdrop.sh /mnt/backups/Mailserver/backdrop/backdrop-$DATE.tar.gz /mnt/backups/Mailserver/backdrop/backdropdb-$DATE.sql
