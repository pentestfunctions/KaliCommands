# Prompt the user for the domain
do {
    $domain = Read-Host "Please enter the domain (e.g., example.com). Do not include http:// or https://"
} while ($domain -match "https?://")

$urls = @(
    "https://www.google.com/search?q=site:$domain",
    "https://dnstwister.report/",
    "https://www.google.com/search?q=site:$domain+intitle:index.of",
    "https://www.google.com/search?q=site:$domain+ext:xml|%20ext:conf|%20ext:cnf|%20ext:reg|%20ext:inf|%20ext:rdp|%20ext:cfg|%20ext:txt|%20ext:ora|%20ext:ini",
    "https://www.google.com/search?q=site:$domain+ext:sql|%20ext:dbf|%20ext:mdb",
    "https://www.google.com/search?q=site:$domain+ext:log",
    "https://www.google.com/search?q=site:$domain+ext:bkf|%20ext:bkp|%20ext:bak|%20ext:old|%20ext:backup",
    "https://www.google.com/search?q=site:$domain+intext:`"sql syntax near`"|%20intext:`"syntax error has occurred`"|%20intext:`"incorrect syntax near`"|%20intext:`"unexpected end of SQL command`"|%20intext:`"Warning: mysql_connect()`"|%20intext:`"Warning: mysql_query()`"|%20intext:`"Warning: pg_connect()`"",
    "https://www.google.com/search?q=site:$domain+filetype:asmx|%20inurl:jws?wsdl|%20filetype:jws|%20inurl:asmx?wsdl",
    "https://www.google.com/search?q=site:$domain+ext:doc|%20ext:docx|%20ext:odt|%20ext:pdf|%20ext:rtf|%20ext:sxw|%20ext:psw|%20ext:ppt|%20ext:pptx|%20ext:pps|%20ext:csv",
    "https://www.google.com/search?q=site:pastebin.com+$domain",
    "https://www.google.com/search?q=site:pastebin.com+`"$domain`"",
    "https://viewdns.info/reverseip/?host=$domain&t=1",
    "https://viewdns.info/iphistory/?domain=$domain",
    "https://viewdns.info/httpheaders/?domain=$domain",
    "https://web.archive.org/cdx/search/cdx?url=*.$domain&output=xml&fl=original&collapse=urlkey",
    "https://web.archive.org/web/20230000000000*/$domain",
    "https://viewdns.info/dnsrecord/?domain=$domain",
    "https://viewdns.info/portscan/?host=$domain",
    "https://crt.sh/?q=$domain",
    "https://who.is/whois/$domain",
    "https://securitytrails.com/list/apex_domain/$domain",
    "https://urlscan.io/search/#$domain",
    "https://www.shodan.io/search?query=$domain",
    "https://search.censys.io/search?resource=hosts&sort=RELEVANCE&per_page=25&virtual_hosts=EXCLUDE&q=$domain",
    "https://dnshistory.org/dns-records/$domain",
    "https://www.wappalyzer.com/lookup/$domain/",
    "https://builtwith.com/$domain",
    "https://sitereport.netcraft.com/?url=http://$domain",
    "https://www.statscrop.com/www/$domain",
    "https://spyonweb.com/$domain",
    "https://securityheaders.com/?q=$domain&followRedirects=on",
    "https://github.com/search?q=$domain&type=code",
    "https://grep.app/search?q=$domain",
    "https://trends.google.com/trends/explore?q=$domain",
    "https://dnssec-debugger.verisignlabs.com/$domain",
    "https://dnsviz.net/d/$domain/analyze/",
    "https://buckets.grayhatwarfare.com/files?keywords=$domain"
    # ... Add any additional URLs as needed
)

# Write URLs to a temporary file in the AppData directory
$tempFile = Join-Path $Env:AppData "tempfile.txt"
$urls | Out-File -FilePath $tempFile -Encoding ASCII

# Convert the Windows path to a WSL path
$wslTempFile = $tempFile -replace 'C:', '/mnt/c' -replace '\\', '/'

# Read URLs from the file in WSL and open them in Brave in different tabs
$wslCommand = "cat `"$wslTempFile`" | xargs brave-browser"
wsl bash -c $wslCommand

# Optionally, remove the temporary file
Remove-Item $tempFile