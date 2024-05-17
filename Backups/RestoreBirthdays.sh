#!/bin/bash

DATE=`date +%F`
/home/ajorians/Documents/git/BackupScripts/Birthdays/RestoreBirthdays.sh /mnt/backups/Mailserver/birthdays/birthday-$DATE.tar.gz /mnt/backups/Mailserver/birthdays/birthdaysdb-$DATE.sql
