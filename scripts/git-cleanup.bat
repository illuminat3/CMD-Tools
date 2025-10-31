@echo off
setlocal enabledelayedexpansion

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not inside a Git repository.
    exit /b 1
)

for /f %%H in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%H

echo Fetching and pruning remotes...
git fetch --all --prune >nul 2>&1
echo Done.
echo.

for /f "tokens=1" %%B in ('
  git for-each-ref --format="%%(refname:short) %%09%%(upstream:track)" refs/heads ^
  ^| findstr /c:"[gone]"
') do (
    if /I not "%%B"=="%CURRENT_BRANCH%" (
        if /I not "%%B"=="main" if /I not "%%B"=="master" if /I not "%%B"=="develop" (
            echo Deleting branch: %%B
            git branch -D "%%B" >nul 2>&1
        )
    )
)

echo.
echo Cleanup complete!
echo.

pause
