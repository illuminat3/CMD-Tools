@echo off
setlocal

where gh >nul 2>nul
if errorlevel 1 (
    echo gh CLI not found. Please install GitHub CLI from https://cli.github.com/
    exit /b 1
)

for /f "delims=" %%i in ('gh api user --jq ".login" 2^>nul') do set GH_USERNAME=%%i
if not defined GH_USERNAME (
    echo Failed to retrieve GitHub username. Are you authenticated with 'gh auth login'?
    exit /b 1
)

for /f "delims=" %%i in ('gh api user --jq ".email" 2^>nul') do set GH_EMAIL=%%i

if "%GH_EMAIL%"=="" (
    set /p GH_EMAIL=No public email found on GitHub. Please enter your Git email address: 
)

git config user.name "%GH_USERNAME%"
git config user.email "%GH_EMAIL%"

echo Git config updated in this repository:
echo   user.name  = %GH_USERNAME%
echo   user.email = %GH_EMAIL%

endlocal
