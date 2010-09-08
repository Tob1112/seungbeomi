#!/bin/sh
#ant -f icontact-air/build.xml
mvn clean compile install
#mvn -f icontact-batch-server/pom.xml jetty:run
#mvn -f icontact-web/pom.xml jetty:run
mvn -f icontact-blazeds/pom.xml jetty:run