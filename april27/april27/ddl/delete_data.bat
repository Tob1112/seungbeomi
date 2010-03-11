echo off

cd workspace\prms\ddl
dir/w
set SQL_CONNECTION="prms/prms@192.168.0.5"
"
set SQL_SOURCE="./delete_data.sql"

sqlplus %SQL_CONNECTION% @ %SQL_SOURCE%

rem for %%A in ( %SQL_SOURCE%*.SQL ) do sqlplus %SQL_CONNECTION% @%%A

pause
exit