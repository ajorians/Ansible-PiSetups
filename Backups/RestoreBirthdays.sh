#!/bin/bash

#Get latest file
LATESTFILE=`find /mnt/backups/Mailserver/birthdays/ -maxdepth 1 -name 'birthdays-*.tar.gz' -printf '%f\n' | sort -nr | head -n1`

echo "LatestFile: $LATESTFILE"

LATESTDATE=`grep -oP "\d{4}-\d{2}-\d{2}" <<< "$LATESTFILE"`

echo "LatestDate: $LATESTDATE"

/home/ajorians/Documents/git/BackupScripts/Birthdays/RestoreBirthdays.sh /mnt/backups/Mailserver/birthdays/birthdays-$LATESTDATE.tar.gz /mnt/backups/Mailserver/birthdays/birthdaysdb-$LATESTDATE.sql
