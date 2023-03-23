#!/bin/bash

# Variablen für die Verbindung zur Datenbank
DB_HOST="mariadb-a"
DB_PORT="3306"
DB_NAME="db"
DB_USER="user"
DB_PASSWORD="password"

# Parameter für den Namen und Vornamen
NAME="$1"
VORNAME="$2"

# Überprüfen, ob die Parameter vorhanden sind
if [[ -z "$NAME" || -z "$VORNAME" ]]; then
  echo "Bitte geben Sie Name und Vorname als Parameter ein."
  exit 1
fi

# SQL-Abfrage zum Einfügen von Name und Vorname in die Datenbank
SQL="INSERT INTO userinfo (name, vorname) VALUES ('$VORNAME', '$NAME')"

# Ausführen der SQL-Abfrage
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "$SQL"

# Überprüfen, ob die Abfrage erfolgreich war
if [[ $? -ne 0 ]]; then
  echo "Fehler beim Einfügen von Name und Vorname in die Datenbank."
  exit 1
fi

echo "Name und Vorname erfolgreich in die Datenbank eingefügt."

