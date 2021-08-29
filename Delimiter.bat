@ECHO OFF
rem set file input and output
SETLOCAL
SET "sourcedir=D:\BATCH RUNNING\Delimit"
SET "destdir=D:\BATCH RUNNING\Delimit"
SET "filename1=%sourcedir%\Input.txt"
SET "outfile=%destdir%\Output.txt"

rem set delimiter 
SET "delimiter=,"

rem  read column-sizes from supplied command-line
rem %* expands to the complete list of arguments passed to the script.
CALL :colsize %*
echo after colsize
pause

(
FOR /f "usebackqdelims=" %%a IN ("%filename1%") DO (
 SET "line=%%a"
 CALL :report
)
)>"%outfile%"

GOTO :EOF

:colsize
SET "magic="
:: offset position
rem set /a <variable>=<expression>
SET /a size=0

:colsizelp
rem magi
IF DEFINED magic (
 SET "magic=%magic%%delimiter%`line:~%size%,%1`"
) ELSE (
 SET "magic=`line:~%size%,%1`"
)
SET /a size +=%1
SHIFT
rem NEQ not equal
IF "%1" neq "" GOTO colsizelp

rem When the end of a batch script is reached,
rem an implied ENDLOCAL is executed for any outstanding SETLOCAL commands
rem issued by that batch script.
SETLOCAL enabledelayedexpansion
SET "magic=!magic:`=%%!"
echo before per
echo %%!
echo %!
echo not
pause
endlocal&SET "magic=set "line=%magic%""
GOTO :eof

:report
CALL %magic%
ECHO %line%
GOTO :eof
