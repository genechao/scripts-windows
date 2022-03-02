@echo off
rem Source: https://superuser.com/questions/1350419/prevent-windows-10-from-sleeping-for-next-lid-closing-only
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:(" %%i in ('powercfg /GETACTIVESCHEME') do set ACTIVESCHEME=%%i
for /f "tokens=2 delims=:(" %%i in ('powercfg -q %ACTIVESCHEME% SUB_BUTTONS LIDACTION ^| findstr "[0-9a-z]*-[0-9a-z]*-[0-9a-z]*-[0-9a-z]*-[0-9a-z]*"') do set FULLPATH=!FULLPATH! %%i
for /f "tokens=2 delims=:(" %%i in ('powercfg /q %FULLPATH% ^| findstr "[0-9]x[0-9]*"') do (
	set CURRENTSETTINGAC=!CURRENTSETTINGDC!
	set CURRENTSETTINGDC=%%i
)
set CURRENTSETTINGAC=%CURRENTSETTINGAC:~-1%
set CURRENTSETTINGDC=%CURRENTSETTINGDC:~-1%
powercfg -SETACVALUEINDEX %FULLPATH% 0
powercfg -SETDCVALUEINDEX %FULLPATH% 0
powercfg /s %ACTIVESCHEME%
echo Disabled sleep on lid close.
echo Waiting to re-enable sleep on lid close...
pause
powercfg -SETACVALUEINDEX %FULLPATH% %CURRENTSETTINGAC%
powercfg -SETDCVALUEINDEX %FULLPATH% %CURRENTSETTINGDC%
powercfg /s %ACTIVESCHEME%
endlocal