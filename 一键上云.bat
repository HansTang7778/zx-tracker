@echo off
chcp 65001 >nul
title ZX Tracker Upload
echo ============================================
echo   ZX Tracker - Upload to GitHub
echo ============================================
echo.
echo Before this step, on GitHub website do:
echo   1) Create empty repo (e.g. zx-tracker, Public)
echo   2) Generate Token (classic, check "repo")
echo.
echo When asked for password, PASTE YOUR TOKEN.
echo ============================================
echo.

where git >nul 2>nul
if %errorlevel% neq 0 (
  echo [ERROR] Git not installed. Get it at https://git-scm.com/download/win
  pause
  exit /b
)

set /p USERNAME=GitHub username:
set /p REPO=Repo name (default zx-tracker):
if "%REPO%"=="" set REPO=zx-tracker

echo.
echo [1/5] git init
git init
echo [2/5] git add .
git add .
echo [3/5] git commit
git commit -m "init zx tracker"
echo [4/5] set remote
git branch -M main
git remote remove origin >nul 2>nul
git remote add origin https://github.com/%USERNAME%/%REPO%.git
echo [5/5] git push (enter username, then paste Token as password)
git push -u origin main

echo.
echo ============================================
if %errorlevel%==0 (
  echo SUCCESS. Go to repo Settings - Pages to enable website.
) else (
  echo FAILED. Send me the error message or screenshot.
)
echo ============================================
pause
