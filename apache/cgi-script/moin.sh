#!/bin/bash

echo "Content-Type: text/plain"

echo

echo $QUERY_STRING

vorname=${QUERY_STRING#&*=}
vorname=${vorname##*=}
name=${QUERY_STRING%%&*}
name=${name#*=}
# insert into the db

mysql --user=username --password=password db << EOF
INSERT INTO userinfo (vorname, name) VALUES ('$vorname', '$name');
EOF

# Respond with a confirmation message
echo "Hallo $vorname $name, dein Name wurde in die Datenbank gespeichert."
