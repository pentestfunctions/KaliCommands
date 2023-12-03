@echo off

:: Check if the script is being run as an administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Successfully updated file association for .ps1 files.
    pause
) else (
    echo Please run this script as an administrator to update file association for .ps1 files.
    pause
    exit /b 1
)

:: Update the file association for .ps1 files
assoc .ps1=Microsoft.PowerShellScript.1
ftype Microsoft.PowerShellScript.1=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "%1" %*
