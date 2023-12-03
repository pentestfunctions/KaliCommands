# Clear the console
Clear-Host

# Define the lists of programs and wordlists
$programs = @('zenity', 'python3', 'nc', 'nmap', 'rustscan', 'wfuzz',
              'curl', 'httpx', 'whatweb', 'wafw00f', 'wpscan', 'dirsearch',
              'gobuster', 'hydra', 'wget', 'enum4linux', 'dig', 'brave-browser')

$wordlists = @('/usr/share/hosting',
               '/usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt',
               '/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt',
               '/usr/share/wordlists/rockyou.txt')

# Function to check program installation in WSL
function Check-WSLProgram {
    param (
        [string]$program
    )
    $output = wsl command -v $program 2>&1
    return $output -notmatch "command not found"
}

# Function to check wordlist existence in WSL
function Check-WSLFile {
    param (
        [string]$file
    )
    $output = wsl test -f $file 2>&1
    return $output -eq $null
}

# Create a list of missing programs
$missingPrograms = @()
foreach ($program in $programs) {
    if (-not (Check-WSLProgram $program)) {
        $missingPrograms += $program
    }
}

# Install missing programs
if ($missingPrograms.Count -gt 0) {
    Write-Host "Installing missing programs:"
    foreach ($program in $missingPrograms) {
        Write-Host "  $program"
        Start-Process "wsl" -ArgumentList "sudo apt-get install -y $program" -Wait
    }
} else {
    Write-Host "All required programs are already installed." -ForegroundColor Green
}

# Check each wordlist
foreach ($wordlist in $wordlists) {
    if (Check-WSLFile $wordlist) {
        Write-Host "$wordlist exists." -ForegroundColor Green
    } else {
        Write-Host "$wordlist does NOT exist." -ForegroundColor Red
    }
}

# Prompt the user to press Enter to exit
Write-Host "`nPress Enter to exit..." -ForegroundColor Yellow
Read-Host
