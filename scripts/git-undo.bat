@echo off
set param=%1
if "%param%"=="" set param=1
git reset --soft HEAD~%param%
