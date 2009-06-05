cd C:\application\workspace\guestbook\guestbook\hsqldb

echo "jdbc:hsqldb:hsql://localhost:9002"

java -classpath ..\WebContent\WEB-INF\lib\hsqldb.jar org.hsqldb.util.DatabaseManager
