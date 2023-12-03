Clear-Host

# Setting console colors
$foregroundColor = "Green"
$highlightColor = "Cyan"
$defaultColor = $host.UI.RawUI.ForegroundColor

function Set-Color {
    param ([string]$color)
    $host.UI.RawUI.ForegroundColor = $color
}

Set-Color $foregroundColor

Write-Host "Welcome to Dirsearch!" -ForegroundColor $highlightColor
Write-Host "--------------------------------------" -ForegroundColor $highlightColor
Write-Host

# Getting target input
$target = Read-Host -Prompt "What is your target"

if (-not $target) {
    Set-Color "Yellow"
    Write-Host "No target specified. Exiting."
    exit
}

Clear-Host

Set-Color $highlightColor
Write-Host "Scanning $target..." -ForegroundColor $highlightColor
Write-Host

# Menu for scan type selection
Write-Host "Select the type of scan:"
Write-Host "1: Quick Scan (Default)"
Write-Host "2: Medium Scan (Uses a specified wordlist)"
Write-Host "3: Long Scan (Uses a specified wordlist + all extensions, excluding 404 pages)"
$scanType = Read-Host -Prompt "Enter your choice (1-3)"

# Executing dirsearch in WSL based on the user's choice
switch ($scanType) {
    "1" { wsl dirsearch --no-color -q -u $target }
    "2" { 
        # Replace 'your_medium_wordlist.txt' with the actual wordlist file path
        wsl dirsearch --no-color -q -u $target -w /path/to/your_medium_wordlist.txt 
    }
    "3" { 
        # Replace 'your_long_wordlist.txt' with the actual wordlist file path
        wsl dirsearch --no-color -q -u $target -w /path/to/your_long_wordlist.txt -e php,txt,html,config --exclude-status 404 
    }
    default { 
        Set-Color "Red"
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
