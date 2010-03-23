echo restore
java -cp h2.jar org.h2.tools.RunScript -url "jdbc:h2:tcp://localhost/~/terasoluna" -user sa -script terasoluna.script -showResults
echo backup
echo java -cp h2.jar org.h2.tools.Script -url "jdbc:h2:tcp://localhost/~/terasoluna" -user sa -script terasoluna.backup