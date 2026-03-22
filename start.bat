@echo off
echo ========================================
echo   GameStudios Engine - Starting Editor
echo ========================================
echo.

REM Check if node_modules exists
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
    echo.
)

echo Starting GameStudios Editor...
echo.
call npm start

if errorlevel 1 (
    echo.
    echo ERROR: Failed to start editor
    pause
    exit /b 1
)

pause
