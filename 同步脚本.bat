@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ======================================
echo   专项工作 · 本地镜像同步
echo ======================================
echo 正在从 GitHub 拉取最新数据…
git pull --ff-only
if errorlevel 1 (
  echo.
  echo [失败] 拉取未成功。请确认：
  echo   1. 本文件夹是仓库克隆（含 .git）
  echo   2. 网络可访问 GitHub
  echo   3. 已配置 git 凭据或 SSH
) else (
  echo.
  echo [完成] 已同步到云端最新版本。
)
echo.
pause
