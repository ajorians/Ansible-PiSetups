#!/bin/bash

#Get latest file
LATESTFILE=`find /mnt/sync/Mailserver/backdrop/ -maxdepth 1 -name 'backdrop-*.tar.gz' -printf '%f\n' | sort -nr | head -n1`

echo "LatestFile: $LATESTFILE"

LATESTDATE=`grep -oP "\d{4}-\d{2}-\d{2}" <<< "$LATESTFILE"`

echo "LatestDate: $LATESTDATE"

/home/ajorians/Documents/git/BackupScripts/Backdrop/RestoreBackdrop.sh /mnt/sync/Mailserver/backdrop/backdrop-$LATESTDATE.tar.gz /mnt/sync/Mailserver/backdrop/backdropdb-$LATESTDATE.sql
