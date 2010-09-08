rem icontact-air
rem ant -f icontact-air/build.xml

mvn clean compile install

rem icontact-batch
rem mvn -f icontact-batch-server/pom.xml jetty:run

rem icontact-web
mvn -f icontact-web/pom.xml jetty:run