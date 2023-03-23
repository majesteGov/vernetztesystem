#!/bin/bash
rm -f apache-tomcat-*.tar.gz
tomcatversion=10.1.4
echo Download $i tomcat $tomcatversion
wget  -nc -P download https://dlcdn.apache.org/tomcat/tomcat-10/v$tomcatversion/bin/apache-tomcat-$tomcatversion.tar.gz;



function doget { # dst version url
  echo "download $dst $version"
  dst=$1
  version=$2
  url="$3"
  wget  -nc -P "download" "$url"
}




dst=jakartaee
version=10.0.0
doget $dst $version https://repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-api/$version/jakarta.jakartaee-api-$version.jar

dst=mariadb-java-client
version=3.1.0
doget $dst $version https://repo1.maven.org/maven2/org/mariadb/jdbc/$dst/$version/$dst-$version.jar

dst=postgresql
version=42.5.1
doget $dst $version https://repo1.maven.org/maven2/org/postgresql/$dst/$version/$dst-$version.jar



