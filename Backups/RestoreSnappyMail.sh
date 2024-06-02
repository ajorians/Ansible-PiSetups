#!/bin/bash

#Get latest file
LATESTFILE=`find /mnt/backups/Mailserver/snappymail/ -maxdepth 1 -name 'snappymail-*.tar.gz' -printf '%f\n' | sort -nr | head -n1`

echo "LatestFile: $LATESTFILE"

LATESTDATE=`grep -oP "\d{4}-\d{2}-\d{2}" <<< "$LATESTFILE"`

echo "LatestDate: $LATESTDATE"

/home/ajorians/Documents/git/BackupScripts/SnappyMail/RestoreSnappyMail.sh /mnt/backups/Mailserver/snappymail/snappymail-$LATESTDATE.tar.gz
