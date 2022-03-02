setlocal
set VSCODE_DATA_SUBDIR=data
set VSCODE_DIR=%~1
if not defined VSCODE_DIR if "%CD%" == "%SystemRoot%" set VSCODE_DIR=%~dp0
if not defined VSCODE_DIR set VSCODE_DIR=%CD%
if not exist "%VSCODE_DIR%" exit /b 1
pushd "%VSCODE_DIR%" || exit /b 1
if not exist "Code.exe" goto error
for %%d in ("user-data" "extensions" "tmp") do mkdir "%VSCODE_DATA_SUBDIR%\%%~d" || goto error
:end
popd
exit /b 0
:error
popd
exit /b 1
