@echo off
rem Check if TCP Port is Open
rem Usage: tcpopen.cmd compname port
rem By: Gene Chao - Last updated: 11/16/2021

call :checktcpopen %1 %2
if %ERRORLEVEL% EQU 0 echo %1:%2 TCP port is open
if %ERRORLEVEL% EQU 1 echo %1:%2 TCP port doesn't appear to be open
if %ERRORLEVEL% EQU 2 echo Usage: tcpopen.cmd compname port
if %ERRORLEVEL% EQU 3 echo Error: Invalid port number


goto :eof
:checktcpopen
setlocal

set _compname=%~1
if defined _compname set _compname=%_compname:"=%
if defined _compname set _compname=%_compname:\=%
if defined _compname set _compname=%_compname: =%
if not defined _compname exit /b 2

set /a "_port=0" && set /a "_port=%2" 2>nul
if %_port% LEQ 0 exit /b 3
if %_port% GTR 65535 exit /b 3

powershell -command $tcptestretval=(Test-NetConnection -ComputerName '%_compname%' -Port %_port%).TcpTestSucceeded; Exit ($tcptestretval -eq $false) >nul 2>&1
endlocal
exit /b %ERRORLEVEL%
