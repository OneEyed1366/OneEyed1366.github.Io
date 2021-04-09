@echo off
@REM Добавляем файлы для публикаций в .gitignore
echo #deploy files>> .gitignore
echo *.bat>> .gitignore
echo *.sh>> .gitignore
@REM Записываем переменные
echo "Waiting for user input (format -> Name-Number)"
set /p branchName=

echo "Do you want to copy this project to GitHub (OneEyed1366 acc), or deploy to the surge?"
echo "1 -> copy to GitHub"
echo "2 -> deploy to Surge"
echo "3 -> Copy and Deploy"
set /p distance=
@REM По необходимости, генерируем проект
echo "Run script for creating production state of the project? (y/n)"
set /p deployAnswer=

set currDate=%date:~6%-%date:~,2%-%date:~3,2%
set donor=C:\Users\proka\NodeJS\deploy\vue\deploy.bat
set file=deploy.bat
set git=https://github.com/OneEyed1366/publicProjects.git
set distanceURL=%currDate%-%branchName%.surge.sh
echo %distanceURL%

if "%deployAnswer%"=="y" (
  npm run build
)

if "%distance%"=="1" goto copyGit
if "%distance%"=="2" goto deploySurge
if "%distance%"=="3" goto copy-and-deploy

:copyGit
git init
git remote add origin %git%
git checkout -b %branchName%
git add -A
git commit -m "Выполнил проект"
git push -u origin %branchName%
echo "Copying to the GitHub public repositore -> Succesful"
pause

:deploySurge
cd dist
surge --domain %distanceURL%
echo "Deploying to the %branchName%.surge.sh -> Succesful"
cd ..
pause

:copy-and-deploy
echo %distanceURL% > link.txt
goto copyGit
goto deploySurge
pause

@REM copy %donor% %file%