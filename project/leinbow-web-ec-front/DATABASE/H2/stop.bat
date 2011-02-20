set H2=h2-1.2.143.jar
set SCRIPT=test.script
set EMBEDDED_MODE=jdbc:h2:~/test
set SERVER_MODE=jdbc:h2:tcp://localhost/~/test

java -cp %H2% org.h2.tools.Server -tcpShutdown tcp://localhost
