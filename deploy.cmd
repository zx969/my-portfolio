@echo off
rem ============================================================
rem  Deploy to Cloudflare Pages (static files only)
rem  Usage: double-click this file, or run  deploy.cmd  in this folder
rem  First time only:  npx wrangler login --device
rem ============================================================
setlocal
cd /d "%~dp0"

set "XDG_CONFIG_HOME=%~dp0.cf-config"
set "WRANGLER=node_modules\wrangler\wrangler-dist\cli.js"

if not exist "%WRANGLER%" (
  echo [ERROR] wrangler not found. Run:  npm install
  exit /b 1
)

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
echo Ensuring Pages project exists: my-portfolio
node "%WRANGLER%" pages project create my-portfolio --production-branch=main 2>nul
echo (if the project already exists, the error above can be ignored)
echo.
echo Deploying to Cloudflare Pages project: my-portfolio
node "%WRANGLER%" pages deploy "_deploy" --project-name=my-portfolio --branch=main --commit-dirty=true

echo.
echo Done. The URL looks like https://<hash>.my-portfolio.pages.dev
endlocal
