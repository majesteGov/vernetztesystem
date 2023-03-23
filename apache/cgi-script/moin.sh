#!/bin/bash

echo "Content-Type: text/plain"

echo

echo $QUERY_STRING

vorname=${QUERY_STRING#&*=}
vorname=${vorname##*=}
name=${QUERY_STRING%%&*}
name=${name#*=}

# call the script to insert in the db 
./adder.sh $vorname $name

# Respond with a confirmation message
echo "Hallo $vorname $name, dein Name wurde in die Datenbank gespeichert."
