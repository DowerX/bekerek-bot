#!/bin/sh

USERNAME=""
PASSWORD=""
BASEURL="https://banyakozpont.mestermc.hu"
USERAGENT="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/110.0"

rm cookie.txt

curl \
    -X GET "$BASEURL" \
    -A "$USERAGENT" \
    -c cookie.txt \
    -s > /dev/null
curl \
    -X POST "$BASEURL/index.php?module=login" \
    -A "$USERAGENT" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "username=$USERNAME&password=$PASSWORD" \
    -b cookie.txt \
    -c cookie.txt \
    -s > /dev/null
curl \
    -X GET "$BASEURL/extra/extrak" \
    -A "$USERAGENT" \
    -b cookie.txt \
    -c cookie.txt \
    -s > /dev/null
curl \
    -X GET "$BASEURL/extra/bkerek" \
    -A "$USERAGENT" \
    -b cookie.txt \
    -c cookie.txt \
    -s > /dev/null
SESSID=$(cat cookie.txt | grep "PHPSESSID" | cut -d "	" -f 7)
curl \
    -X POST "$BASEURL/kerekseged.php" \
    -A "$USERAGENT" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "nev=$USERNAME&sessid=$SESSID" \
    -b cookie.txt \
    -s | grep "nyeremeny"