#!/bin/sh
H2=h2/h2.jar
SCRIPT=h2/test.script
EMBEDDED_MODE=jdbc:h2:~/test
SERVER_MODE=jdbc:h2:tcp://localhost/~/test

java -cp $H2 org.h2.tools.RunScript -url $EMBEDDED_MODE -user sa -script $SCRIPT -showResults