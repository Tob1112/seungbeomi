echo
echo restore
java -cp ../lib/h2.jar org.h2.tools.RunScript -url "jdbc:h2:~/test" -user sa -script test.script -showResults
echo
echo backup
echo java -cp ../lib/h2.jar org.h2.tools.Script -url "jdbc:h2:~/test" -user sa -script test.backup
echo