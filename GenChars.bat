@echo off
rem
setlocal enabledelayedexpansion
set "string=abcdefghijklmnopqrstuvwxyz"
:start
set "result="
set /p WordLen="Enter number of cha: "

for /L %%i in (1,1,%WordLen%) do call :add

rem Output to text file
echo %WordLen% >> Word_Length.txt
echo %result% >> Word_Length.txt
goto :start

:add
set /a x=%random% %% 26
set result=%result%!string:~%x%,1!
goto :eof
