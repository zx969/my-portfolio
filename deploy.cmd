@echo off
rem ============================================================
rem  Deploy to Cloudflare Workers (static assets)
rem  Usage: double-click this file, or run  deploy.cmd  in this folder
rem  URL after deploy: https://my-portfolio.zx969.workers.dev
rem ============================================================
setlocal
cd /d "%~dp0"

set "XDG_CONFIG_HOME=%~dp0.cf-config"
set "WRANGLER=node_modules\wrangler\wrangler-dist\cli.js"

if not exist "%WRANGLER%" (
  echo [ERROR] wrangler not found. Run:  npm install
  exit /b 1
)

rem 1) stage pure static files (never upload .git / node_modules / _tools)
if exist "_deploy" rmdir /s /q "_deploy"
mkdir "_deploy"
copy /y "index.html" "_deploy\" >nul
xcopy /y /e /i /q "assets" "_deploy\assets" >nul
for %%F in (404.html robots.txt _headers _redirects) do (
  if exist "%%F" copy /y "%%F" "_deploy\" >nul
)

echo Staged files:
dir /b /s "_deploy" | findstr /v /c:"_deploy\\"
echo.
echo Deploying to Cloudflare Workers: my-portfolio
node "%WRANGLER%" deploy

echo.
echo Done. Site URL: https://my-portfolio.zx969.workers.dev
endlocal
