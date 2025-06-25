@echo off
:: Check for admin rights by trying to create a folder in a protected location
fsutil dirty query %systemdrive% >nul 2>&1
if errorlevel 1 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb runAs"
    exit /b
)
:: Your batch code starts here, running as admin

title Stop Roblox Cheats
color 0c

:: Show warning message (Windows message box using mshta)
mshta "javascript:var sh=new ActiveXObject('WScript.Shell'); sh.Popup('Roblox cheats detected! They will be stopped.\n\nPlease play fair and respect the game rules.', 10, 'Stop Roblox Cheats', 48);close()"

:: List of cheat process names to kill (customize as needed)
set cheatProcesses=FreeRobloxCheats.exe RobloxCheatTool.exe CheatEngine.exe

for %%p in (%cheatProcesses%) do (
    tasklist /FI "IMAGENAME eq %%p" | find /I "%%p" >nul
    if not errorlevel 1 (
        echo Stopping cheat process: %%p
        taskkill /F /IM %%p >nul 2>&1
    )
)

:: Delete fake cheat folder if exists
set cheatFolder=%USERPROFILE%\AppData\Local\FreeRobloxCheats
if exist "%cheatFolder%" (
    echo Deleting cheat folder: %cheatFolder%
    rmdir /S /Q "%cheatFolder%"
)

echo.
echo Cheat blocking complete. Please play fair!
pause