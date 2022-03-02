@echo off
rem Add/Delete User Profile Permissions
rem Usage: Windows-UserProfile-Permissions-Modify.cmd profilefolder user/group [a/d]
rem By: Gene Chao - Last updated: 9/26/2019

setlocal

set _dir=%~f1
if not defined _dir goto usage
if "%_dir:~-1%" == "\" set _dir=%_dir:~0,-1%
if not defined _dir goto usage
if not exist "%_dir%\" goto notexist

set _user=%~2
if not defined _user goto usage
if "%_user:~0,2%" == ".\" set _user=%COMPUTERNAME%\%_user:~2%

set _action=%~3
if not defined _action goto usage
if /i "%_action:~0,1%" == "a" set _action_param=/grant "%_user%:(OI)(CI)(M)"
if /i "%_action:~0,1%" == "d" set _action_param=/remove:g "%_user%"
if not defined _action_param goto usage

icacls "%_dir%" %_action_param% /C /L /Q

endlocal

goto :eof
:usage
echo Usage: %0 profilefolder user/group [a/d]
exit /b 1

goto :eof
:notexist
echo Folder doesn't exist
exit /b 1
