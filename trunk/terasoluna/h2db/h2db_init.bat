SET H2URL=jdbc:h2:~/terasoluna
SET H2USER=sa

REM restore
java -cp h2.jar org.h2.tools.RunScript -url %H2URL% -user %H2USER% -script terasoluna.script -showResults

REM backup
REM java -cp h2.jar org.h2.tools.Script -url %H2URL% -user %H2USER% -script terasoluna.backup

pause