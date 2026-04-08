@echo off
setlocal enabledelayedexpansion

echo ===============================
echo Running QLSVNCKH API Tests
echo ===============================

REM Kiểm tra tham số đầu vào (chỉ cần ModuleName)
IF "%~1"=="" (
    echo Usage: %~nx0 ^<ModuleName^>
    exit /b 1
)

set "MODULE_NAME=%~1"

REM Thư mục hiện tại của script
set "CURRENT_DIR=%~dp0"
REM Xóa dấu \ cuối nếu có
if "%CURRENT_DIR:~-1%"=="\" set "CURRENT_DIR=%CURRENT_DIR:~0,-1%"

REM Tạo thư mục reports nếu chưa có
if not exist "%CURRENT_DIR%\%MODULE_NAME%\reports" (
    mkdir "%CURRENT_DIR%\%MODULE_NAME%\reports"
)

REM Đường dẫn báo cáo
set "REPORT_PATH=%CURRENT_DIR%\%MODULE_NAME%\reports\report.html"
set "JSON_PATH=%CURRENT_DIR%\%MODULE_NAME%\reports\output.json"

REM Chạy Newman (không dùng folder)
call newman run "%CURRENT_DIR%\%MODULE_NAME%\%MODULE_NAME%.postman_collection.json" ^
  -e "%CURRENT_DIR%\workspace.postman_globals.json" ^
  --iteration-data "%CURRENT_DIR%\%MODULE_NAME%\TestData.json" ^
  --reporters cli,htmlextra,json ^
  --reporter-htmlextra-export "%REPORT_PATH%" ^
  --reporter-json-export "%JSON_PATH%" ^
  --reporter-htmlextra-title "QLSVNCKH API Test Report - %MODULE_NAME%" ^
  --reporter-htmlextra-darkTheme ^
  --reporter-htmlextra-showEnvironmentData ^
  --reporter-htmlextra-logs ^
  --insecure

echo ===============================
echo Test run completed!
echo HTML report: %REPORT_PATH%
echo ===============================
pause