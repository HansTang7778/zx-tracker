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
echo [0] set git identity
git config user.name "%USERNAME%"
git config user.email "%USERNAME%@users.noreply.github.com"

echo [1] git init
git init
echo [2] git add
git add -A
echo [3] git commit
git diff --cached --quiet 2>nul && echo (no changes to commit) || git commit -m "init zx tracker"
echo [4] set remote
git branch -M main
git remote remove origin >nul 2>nul
git remote add origin https://github.com/%USERNAME%/%REPO%.git
echo [5] git push
git push -u origin main > push_log.txt 2>&1
type push_log.txt

echo.
echo ============================================
findstr /i "error" push_log.txt >nul
if %errorlevel%==0 (
  echo FAILED. Open push_log.txt in this folder and send it to me.
) else (
  echo SUCCESS. Go to repo Settings - Pages to enable website.
)
echo ============================================
pause
