These are basic utilities related to JDBC.

This project can be built using Maven (http://maven.apache.org).  It can also be imported into 
the Eclipse IDE, but the Maven repository variable will need to be set and the Maven build 
will need to be run at least once if you don't already have all the jars the project needs 
downloaded to your local Maven repository.  The project is also setup to use the 
Spring IDE (http://springide.org).

	mvn -Declipse.workspace=<path-to-eclipse-workspace> eclipse:add-maven-repo