@echo off

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not inside a Git repository.
    exit /b 1
)

echo Fetching and pruning remotes...
git fetch -p >nul 2>&1
echo Done.
echo.

for /f "tokens=1" %%b in ('git branch -vv ^| findstr /c:"[gone]"') do (
    echo Deleting branch: %%b
    git branch -d %%b >nul 2>&1
)

echo.
echo Cleanup complete!
echo.

pause
