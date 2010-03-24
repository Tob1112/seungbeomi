echo
echo restore
java -cp h2.jar org.h2.tools.RunScript -url "jdbc:h2:tcp://localhost/~/blank" -user sa -script blank.script -showResults
echo
echo backup
echo java -cp h2.jar org.h2.tools.Script -url "jdbc:h2:tcp://localhost/~/blank" -user sa -script blank.backup
echo
