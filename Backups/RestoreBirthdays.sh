#!/bin/bash

DATE=`date +%F`
/home/ajorians/Documents/git/BackupScripts/Birthdays/RestoreBirthdays.sh /mnt/backups/Mailserver/birthdays/birthdays-$DATE.tar.gz /mnt/backups/Mailserver/birthdays/birthdaysdb-$DATE.sql
