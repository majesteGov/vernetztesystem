#!/bin/bash

echo "Content-Type: text/plain"

echo

echo $QUERY_STRING


# Variablen für die Verbindung zur Datenbank
DB_HOST="mariadb-a"
DB_PORT="3306"
DB_name="db"
DB_USER="user"
DB_PASSWORD="password"
# Extract the parameters from the curl request
QUERY_STRING=$(echo $QUERY_STRING | tr -d '\r')
PARAMS=$(echo $QUERY_STRING | tr '&' '\n')

# Parse the parameters and store them in variables
vorname=$(echo "$PARAMS" | grep -oP '(?<=vorname=)[^&]+')
name=$(echo "$PARAMS" | grep -oP '(?<=name=)[^&]+')

echo "Hallo $vorname $name"
# Überprüfen, ob die Parameter vorhanden sind
if [[ -z "$vorname" || -z "$name" ]]; then
        echo "Bitte geben Sie einen Name und einen Vorname als Parameter ein."
        exit 1
fi

# Datenvalidierung
if [[ ! "$vorname" =~ ^[a-zA-Z]+$ ]]; then
        echo "Vorname muss aus Buchstaben bestehen."
        exit 1
fi

if [[ ! "$name" =~ ^[a-zA-Z]+$ ]]; then
        echo "Name muss aus Buchstaben bestehen."
        exit 1
fi

# SQL-Abfrage zum Einfügen von Name und Vorname in die Datenbank
SQL="INSERT INTO userinfo (name, vorname) VALUES ('$name', '$vorname')"

# Ausführen der SQL-Abfrage
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_name" -e "$SQL"

# Überprüfen, ob die Abfrage erfolgreich war
if [[ $? -ne 0 ]]; then
        echo "Fehler beim Einfügen von Name und Vorname in die Datenbank."
        exit 1
fi
