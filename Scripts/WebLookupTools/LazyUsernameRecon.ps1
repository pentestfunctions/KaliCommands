# Prompt the user for the username
$username = Read-Host "Please enter the username"

# Define the list of social media sites
$socialMediaSites = @(
    "https://twitter.com/$username", "https://www.tiktok.com/@$username",
    "https://disqus.com/by/$username", "https://instagram.com/$username", "https://www.pinterest.com/$username",
    "https://facebook.com/$username", "https://patreon.com/$username",
    "https://imgur.com/user/$username", "https://pastebin.com/u/$username",
    "https://reddit.com/user/$username", "https://twitch.tv/$username", "https://fiverr.com/$username",
    "https://ask.fm/$username", "https://medium.com/@$username", "https://github.com/$username",
    "https://github.com/search?q=$username&type=repositories", "https://flickr.com/people/$username",
    "https://themeforest.net/user/$username", "https://myspace.com/$username", "https://www.searchblogspot.com/search?q=$username",
    "https://www.kickstarter.com/profile/$username", "https://about.me/$username", "https://deviantart.com/$username",
    "https://www.reverbnation.com/$username", "https://www.behance.net/$username", "https://buzzfeed.com/$username",
    "https://soundcloud.com/$username", "https://tumblr.com/$username", "https://grep.app/search?q=$username",
    "$username.newgrounds.com", "$username.bandcamp.com/", "https://youtube.com/@$username"
)

# Write URLs to a temporary file in the AppData directory
$tempFile = Join-Path $Env:AppData "tempfile.txt"
$socialMediaSites | Out-File -FilePath $tempFile -Encoding ASCII

# Convert the Windows path to a WSL path
$wslTempFile = $tempFile -replace 'C:', '/mnt/c' -replace '\\', '/'

# Read URLs from the file in WSL and open them in Brave in different tabs
$wslCommand = "cat `"$wslTempFile`" | xargs brave-browser"
wsl bash -c $wslCommand

# Optionally, remove the temporary file
Remove-Item $tempFile