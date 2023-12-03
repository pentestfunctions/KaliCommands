Clear-Host

# Setting console colors
$foregroundColor = "Green"
$highlightColor = "Cyan"
$warningColor = "Yellow"
$errorColor = "Red"
$defaultColor = $host.UI.RawUI.ForegroundColor

function Set-Color {
    param ([string]$color)
    $host.UI.RawUI.ForegroundColor = $color
}

Set-Color $foregroundColor

Write-Host "Welcome to Quick Port Scan!" -ForegroundColor $highlightColor
Write-Host "--------------------------------------" -ForegroundColor $highlightColor
Write-Host

# Getting target input
$target = Read-Host -Prompt "What is your target"

if (-not $target) {
    # If target is not set, ask the user to input it through Zenity in WSL
    Set-Color $warningColor
    $target = wsl zenity --entry --text "What is your target?" --title "Set Target Variable"
    if (-not $target) {
        Set-Color $errorColor
        Write-Host "No target specified. Exiting."
        exit
    }
}

Write-Host

# Menu for scan type selection
Set-Color $highlightColor
Write-Host "Select the type of scan:"
Write-Host "--------------------------------------" -ForegroundColor $highlightColor
Write-Host "1: Quick Scan (-F)"
Write-Host "2: Intense Scan"
Write-Host "3: Intense Scan plus UDP"
Write-Host "4: Intense Scan, all TCP ports"
Write-Host "5: Ping Scan"
Write-Host "--------------------------------------" -ForegroundColor $highlightColor
Set-Color $foregroundColor
$scanType = Read-Host -Prompt "Enter your choice (1-5)"

Clear-Host

Set-Color $highlightColor
Write-Host "Scanning $target..." -ForegroundColor $highlightColor
Write-Host

# Executing nmap scan in WSL based on the user's choice
switch ($scanType) {
    "1" { wsl nmap -F $target }
    "2" { wsl nmap -T4 -A -v $target }
    "3" { wsl nmap -sS -sU -T4 -A -v $target }
    "4" { wsl nmap -p 1-65535 -T4 -A -v $target }
    "5" { wsl nmap -sn $target }
    default {
        Set-Color $errorColor
        Write-Host "Invalid selection. Exiting."
        exit
    }
}

Set-Color $highlightColor
Write-Host
Write-Host "Scan complete!" -ForegroundColor $highlightColor

# Pause
Set-Color $defaultColor
Read-Host -Prompt "Press Enter to exit"
