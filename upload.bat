@echo off
echo ===================================================
echo Uploading Namoza Assignment to GitHub...
echo ===================================================
cd /d "%~dp0"
git init
git remote remove origin >nul 2>&1
git remote add origin https://github.com/ruchiyadav0070/ruchi890.git
git branch -M main
git add .
git commit -m "Upload Namoza Developer Assignment deliverables"
echo.
echo Pushing code to GitHub. If prompted, please log in...
git push -u origin main --force
echo ===================================================
echo Done! Please check https://github.com/ruchiyadav0070/ruchi890
echo ===================================================
pause
