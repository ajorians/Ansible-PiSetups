#!/bin/bash

#Get latest file
LATESTFILE=`find /mnt/sync/Mailserver/mediawiki/ -maxdepth 1 -name 'mediawiki-*.tar.gz' -printf '%f\n' | sort -nr | head -n1`

echo "LatestFile: $LATESTFILE"

LATESTDATE=`grep -oP "\d{4}-\d{2}-\d{2}" <<< "$LATESTFILE"`

echo "LatestDate: $LATESTDATE"

/home/ajorians/Documents/git/BackupScripts/MediaWiki/RestoreMediaWiki.sh /mnt/sync/Mailserver/mediawiki/mediawiki-$LATESTDATE.tar.gz /mnt/sync/Mailserver/mediawiki/mediawikidb-$LATESTDATE.sql
