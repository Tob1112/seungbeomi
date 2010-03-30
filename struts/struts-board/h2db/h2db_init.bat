SET H2URL=jdbc:h2:~/struts
SET H2USER=sa

java -cp h2.jar org.h2.tools.RunScript -url %H2URL% -user %H2USER% -script struts.script -showResults

REM java -cp h2.jar org.h2.tools.Script -url %H2URL% -user %H2USER% -script struts.backup

pause

