#!/bin/bash

# Print HTTP headers
echo "Content-Type: text/html"
echo ""

# Connect to the database and retrieve all names
result=$(mysql --user=username --password=password dbname -N -B -e "SELECT CONCAT(vorname, ' ', name) FROM names")

# Format the results as an HTML list
echo "<html>"
echo "<body>"
echo "<h2>Names in the database:</h2>"
echo "<ul>"
while read -r line; do
  echo "<li>$line</li>"
done <<< "$result"
echo "</ul>"
echo "</body>"
echo "</html>"

