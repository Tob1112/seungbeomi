echo
echo restore
java -cp h2.jar org.h2.tools.RunScript -url "jdbc:h2:~/chronos" -user sa -script chronos.script -showResults
echo
echo backup
echo java -cp h2.jar org.h2.tools.Script -url "jdbc:h2:~/chronos" -user sa -script chronos.backup
echo
