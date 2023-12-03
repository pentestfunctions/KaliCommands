# Initialize a hashtable to store selected options with their values
$selectedOptions = @{}

# Function to display the menu and toggle options
Function ShowMenu {
    Clear-Host
    Write-Host "wpscan Command Builder"
    Write-Host "----------------------"
    Write-Host "Current Command:"
    $command = "wpscan"
    $selectedOptions.GetEnumerator() | ForEach-Object {
        $option = $_.Key
        $value = $_.Value
        if ($value -eq $null) {
            $command += " --$option"
        } else {
            $command += " --$option $value"
        }
    }
    Write-Host "   $command"
    Write-Host ""
    Write-Host "Menu Options:"
    Write-Host "1. URL"
    Write-Host "2. Verbose mode"
    Write-Host "3. Output to FILE"
    Write-Host "4. Format"
    Write-Host "5. Detection Mode"
    Write-Host "6. Random User-Agent"
    Write-Host "7. HTTP Auth"
    Write-Host "8. Max Threads"
    Write-Host "9. Throttle"
    Write-Host "10. Request Timeout"
    Write-Host "11. Connect Timeout"
    Write-Host "12. Disable TLS Checks"
    Write-Host "13. Proxy"
    Write-Host "14. Proxy Auth"
    Write-Host "15. Cookie String"
    Write-Host "16. Cookie Jar"
    Write-Host "17. Force"
    Write-Host "18. Update Database"
    Write-Host "19. API Token"
    Write-Host "20. wp-content Directory"
    Write-Host "21. wp-plugins Directory"
    Write-Host "22. Enumerate"
    Write-Host "23. Exclude Content-based"
    Write-Host "24. Plugins Detection"
    Write-Host "25. Plugins Version Detection"
    Write-Host "26. Exclude Usernames"
    Write-Host "27. Passwords"
    Write-Host "28. Usernames"
    Write-Host "29. Multicall Max Passwords"
    Write-Host "30. Password Attack"
    Write-Host "31. Login URI"
    Write-Host "32. Stealthy"
    Write-Host "R. Run Command"
    Write-Host "Q. Quit"
    Write-Host ""
}

# Function to build the wpscan command
Function BuildWpscanCommand {
    $command = "wpscan"
    $selectedOptions.GetEnumerator() | ForEach-Object {
        $option = $_.Key
        $value = $_.Value
        if ($value -eq $null) {
            $command += " --$option"
        } else {
            $command += " --$option $value"
        }
    }
    Write-Host ""
    Write-Host "Current Command:"
    Write-Host "$command"
    Write-Host ""
    Read-Host "Press Enter to continue..." | Out-Null
}

# Function to run the wpscan command using wsl
Function RunWpscanCommand {
    $command = BuildWpscanCommand
    $wslCommand = "wsl " + $command
    & $wslCommand
}

# Main loop
While ($true) {
    ShowMenu
    $choice = Read-Host "Enter your choice (or 'Q' to quit):"
    Switch ($choice) {
        "1" { $selectedOptions["url"] = Read-Host "Enter URL" }
        "2" { $selectedOptions["verbose"] = $null }
        "3" { $selectedOptions["output"] = Read-Host "Enter FILE" }
        "4" { $selectedOptions["format"] = Read-Host "Enter FORMAT" }
        "5" { $selectedOptions["detection-mode"] = Read-Host "Enter MODE" }
        "6" { $selectedOptions["random-user-agent"] = $null }
        "7" { $selectedOptions["http-auth"] = Read-Host "Enter login:password" }
        "8" { $selectedOptions["max-threads"] = Read-Host "Enter VALUE" }
        "9" { $selectedOptions["throttle"] = Read-Host "Enter MilliSeconds" }
        "10" { $selectedOptions["request-timeout"] = Read-Host "Enter SECONDS" }
        "11" { $selectedOptions["connect-timeout"] = Read-Host "Enter SECONDS" }
        "12" { $selectedOptions["disable-tls-checks"] = $null }
        "13" { $selectedOptions["proxy"] = Read-Host "Enter protocol://IP:port" }
        "14" { $selectedOptions["proxy-auth"] = Read-Host "Enter login:password" }
        "15" { $selectedOptions["cookie-string"] = Read-Host "Enter COOKIE" }
        "16" { $selectedOptions["cookie-jar"] = Read-Host "Enter FILE-PATH" }
        "17" { $selectedOptions["force"] = $null }
        "18" { $selectedOptions["update"] = $null }
        "19" { $selectedOptions["api-token"] = Read-Host "Enter TOKEN" }
        "20" { $selectedOptions["wp-content-dir"] = Read-Host "Enter DIR" }
        "21" { $selectedOptions["wp-plugins-dir"] = Read-Host "Enter DIR" }
        "22" { $selectedOptions["enumerate"] = Read-Host "Enter [OPTS]" }
        "23" { $selectedOptions["exclude-content-based"] = Read-Host "Enter REGEXP_OR_STRING" }
        "24" { $selectedOptions["plugins-detection"] = Read-Host "Enter MODE" }
        "25" { $selectedOptions["plugins-version-detection"] = Read-Host "Enter MODE" }
        "26" { $selectedOptions["exclude-usernames"] = Read-Host "Enter REGEXP_OR_STRING" }
        "27" { $selectedOptions["passwords"] = Read-Host "Enter FILE-PATH" }
        "28" { $selectedOptions["usernames"] = Read-Host "Enter LIST" }
        "29" { $selectedOptions["multicall-max-passwords"] = Read-Host "Enter MAX_PWD" }
        "30" { $selectedOptions["password-attack"] = Read-Host "Enter ATTACK" }
        "31" { $selectedOptions["login-uri"] = Read-Host "Enter URI" }
        "32" { $selectedOptions["stealthy"] = $null }
        "R" { RunWpscanCommand }
        "Q" { break }
        Default { Write-Host "Invalid choice. Please try again." }
    }
}
