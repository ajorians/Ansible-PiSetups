#!/bin/bash

rm cookie.txt

HOSTNAME="http://192.168.0.72"
PASSWORD="changemeaj"

USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
ACCEPT="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"

# Login
LOGIN_RESULT=`curl "$HOSTNAME/admin/login.php" \
  -H "Accept: $ACCEPT" \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Cookie: PHPSESSID=c093o306ulajjgra66hiqgdiip' \
  -H "Origin: $HOSTNAME" \
  -H "Referer: $HOSTNAME/admin/login.php" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H "User-Agent: $USER_AGENT" \
  --data-raw "pw=$PASSWORD" \
  --include \
  --no-progress-meter \
  --cookie-jar cookie.txt \
  --insecure`

REGEX_COOKIE="Set-Cookie: PHPSESSID=(.+?); path=\/"
if [[ $LOGIN_RESULT =~ $REGEX_COOKIE ]]
then
    COOKIE=${BASH_REMATCH[1]}

#    echo "Cookie is: $COOKIE"
else
    echo "Couldn't find cookie :("
    exit 1
fi

# Post Login
POSTLOGIN_RESULT=`curl "$HOSTNAME/admin/" \
  -H "Accept: $ACCEPT" \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H "Cookie: PHPSESSID=$COOKIE" \
  -H "Referer: $HOSTNAME/admin/login.php" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H "User-Agent: $USER_AGENT" \
  --include \
  --no-progress-meter \
  --cookie-jar cookie.txt \
  --insecure`

# Settings
SETTINGS_RESULT=`curl "$HOSTNAME/admin/settings.php" \
  -H "Accept: $ACCEPT" \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Connection: keep-alive' \
  -H "Cookie: PHPSESSID=$COOKIE" \
  -H "Referer: $HOSTNAME/admin/groups-clients.php" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H "User-Agent: $USER_AGENT" \
  --include \
  --no-progress-meter \
  --cookie-jar cookie.txt \
  --insecure`

REGEX="<input type=\"hidden\" name=\"token\" value=\"([0-9a-zA-Z\/=+]*)\">"
if [[ $SETTINGS_RESULT =~ $REGEX ]]
then
    TOKEN=${BASH_REMATCH[1]}

#    echo "TOKEN: $TOKEN"

    ESCAPED_TOKEN=$(echo $TOKEN | sed -r 's/=/%3D/g')
    ESCAPED_TOKEN=$(echo $ESCAPED_TOKEN | sed -r 's/\+/%2B/g')
    ESCAPED_TOKEN=$(echo $ESCAPED_TOKEN | sed -r 's/\//%2F/g')

#    echo "ESCAPEDTOKEN: $ESCAPED_TOKEN"
else
    echo "Couldn't find token :("
    exit 1
fi

## Find out if has static hosts
NUM_HOSTS=`echo "$SETTINGS_RESULT" | grep -oP '<td data-order=\".+">.+<\/td>' | wc -l`
if (( NUM_HOSTS > 0 )); then
   echo "NUM_HOSTS: $NUM_HOSTS"
   echo "Has hosts so exiting"
   exit 0
fi

jq -c '.[]' data.json | while read i; do
   MAC=$(echo "$i"|jq -c '.MAC'| tr -d '"')
   IP=$(echo "$i"|jq -c '.IP'| tr -d '"')
   HOST=$(echo "$i"|jq -c '.Hostname'| tr -d '"')

   echo "MAC: $MAC; IP: $IP; HOST: $HOST"

   ESCAPEDMAC=$(echo $MAC | sed -r 's/:/%3A/g')
#   echo "ESCAPED: $ESCAPEDMAC"

   ADD_RESULT=`curl "$HOSTNAME/admin/settings.php?tab=piholedhcp" \
     -H "Accept: $ACCEPT" \
     -H 'Accept-Language: en-US,en;q=0.9' \
     -H 'Cache-Control: max-age=0' \
     -H 'Connection: keep-alive' \
     -H 'Content-Type: application/x-www-form-urlencoded' \
     -H "Cookie: PHPSESSID=$COOKIE" \
     -H "Origin: $HOSTNAME" \
     -H "Referer: $HOSTNAME/admin/settings.php?tab=piholedhcp" \
     -H 'Upgrade-Insecure-Requests: 1' \
     -H "User-Agent: $USER_AGENT" \
     --data-raw "DHCPLeasesTable_length=5&DHCPStaticLeasesTable_length=5&AddMAC=$ESCAPEDMAC&AddIP=$IP&AddHostname=$HOST&addstatic=&field=DHCP&token=$ESCAPED_TOKEN" \
     --include \
     --no-progress-meter \
     --cookie-jar cookie.txt \
     --insecure`

#     echo "$ADD_RESULT" > /srv/www/htdocs/allwrite/addresult.htm

done

# Save
SAVE_RESULT=`curl "$HOSTNAME/admin/settings.php?tab=piholedhcp" \
  -H "Accept: $ACCEPT" \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H "Cookie: PHPSESSID=$COOKIE" \
  -H "Origin: $HOSTNAME" \
  -H "Referer: $HOSTNAME/admin/settings.php?tab=piholedhcp" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H "User-Agent: $USER_AGENT" \
  --data-raw "DHCPLeasesTable_length=5&DHCPStaticLeasesTable_length=5&AddMAC=&AddIP=&AddHostname=&field=DHCP&token=$ESCAPED_TOKEN" \
  --include \
  --no-progress-meter \
  --cookie-jar cookie.txt \
  --insecure`

#echo "$SAVE_RESULT" > /srv/www/htdocs/allwrite/save.htm

echo "Finished saving :)"

