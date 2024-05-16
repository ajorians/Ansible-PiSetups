#!/bin/bash

DATE=`date +%F`
/home/ajorians/Documents/git/BackupScripts/MediaWiki/RestoreMediaWiki.sh /mnt/backups/Mailserver/mediawiki/mediawiki-$DATE.tar.gz /mnt/backups/Mailserver/mediawiki/mediawikidb-$DATE.sql
