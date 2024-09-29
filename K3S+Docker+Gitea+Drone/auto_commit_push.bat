@echo off
:: Switch to the directory where the script is located
cd /d %~dp0

:: Add all changed files
echo Adding files...
git add *

:: Commit with a message "Auto commit"
echo Committing changes...
git commit -m "Auto commit"

:: Push changes to the remote repository
echo Pushing to remote repository...
git push

:: Operation complete message
echo Commit and push complete!
pause
