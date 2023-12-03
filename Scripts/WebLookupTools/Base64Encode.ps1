# PowerShell script

# Check if brave-browser is already installed in WSL
$braveInstalled = Invoke-Expression -Command "wsl which brave-browser"

if (-not $braveInstalled) {
    # Install brave-browser if it's not already installed
    Start-Process "wsl" -ArgumentList "sudo apt-get install brave-browser" -Wait
}

# Check if brave-browser is installed (again) after attempting to install
$braveInstalled = Invoke-Expression -Command "wsl which brave-browser"

if ($braveInstalled) {
    # Open Brave browser with multiple tabs
    Start-Process "wsl" -ArgumentList "brave-browser 'https://www.base64encode.org/'" -WindowStyle Hidden
} else {
    Write-Host "Brave browser is not installed. Installation may have failed."
}


