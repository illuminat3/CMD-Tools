@echo off
setlocal

:: Get the directory of this script
set "currentDir=%~dp0"
:: Remove trailing backslash if it exists
if "%currentDir:~-1%"=="\" set "currentDir=%currentDir:~0,-1%"

:: Build full path to scripts folder
set "scriptsPath=%currentDir%\scripts"

:: Add to PATH for current session
set "PATH=%PATH%;%scriptsPath%"

echo Added "%scriptsPath%" to PATH for this session.
