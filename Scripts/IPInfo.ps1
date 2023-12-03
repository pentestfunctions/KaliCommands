Clear-Host

# Setting console color
$host.UI.RawUI.ForegroundColor = "Green"

Write-Host "Your IP information!"
Write-Host "--------------------------------------"
Write-Host

# Run ifconfig in WSL and parse its output to get network adapter names and their IPv4 addresses
$ifconfigOutput = wsl ifconfig
$adapters = $ifconfigOutput -split '\n\n' | Where-Object { $_ -match 'inet\s+\d{1,3}(\.\d{1,3}){3}' }

foreach ($adapter in $adapters) {
    $adapterName = ($adapter -split '\n')[0] -replace ':.*', ''
    $ipv4Address = ($adapter | Select-String -Pattern 'inet\s+(\d{1,3}(\.\d{1,3}){3})' -AllMatches).Matches.Groups[1].Value
    Write-Host "Adapter: $adapterName"
    Write-Host "IPv4 Address: $ipv4Address"
    Write-Host "--------------------------------------"
}

# Get and format public IP address (silently)
$publicIP = wsl curl -s ifconfig.me
Write-Host "Public IP Address: $publicIP"
Write-Host "--------------------------------------"

Write-Host "Scan complete!"

# Pause
Read-Host -Prompt "Press Enter to exit"
