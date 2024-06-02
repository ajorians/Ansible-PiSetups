#!/bin/bash

#Get latest file
LATESTFILE=`find /mnt/backups/Mailserver/mailserver/ -maxdepth 1 -name 'mailserver-*.tar.gz' -printf '%f\n' | sort -nr | head -n1`

echo "LatestFile: $LATESTFILE"

LATESTDATE=`grep -oP "\d{4}-\d{2}-\d{2}" <<< "$LATESTFILE"`

echo "LatestDate: $LATESTDATE"

/home/ajorians/Documents/git/BackupScripts/MailServer/RestoreMailServer.sh /mnt/backups/Mailserver/mailserver/mailserver-$LATESTDATE.tar.gz
