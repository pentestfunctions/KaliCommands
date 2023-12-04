# KaliCommands
Repository for making WSL and Windows one. 

The goal of this project is to instead of just run windows versions of apps, instead run their correct versions through WSL but have them feel native and running through windows. Giving us much more flexibility. 

<p align="center">
  <img src="static/WSLToWindows.gif">
</p>


### Installation
Well you should already have WSL installed so I guess just make sure for now y ou have git installed on the wsl machine.

```bash
wsl sudo apt-get install git
wsl git clone https://github.com/pentestfunctions/KaliCommands.git /mnt/c/KaliCommands
```
- Run that directly in a standard windows terminal. 

2 Extra files come with it:
```
GraphicalFix.bat
SetPowershellAsDefaultApplication.bat
```

Just run both of them as administrator inside the C:\KaliCommands\Scripts folder
1. GraphicalFix fixes some GUI issues with WSL applications (If you get glitches).
2. SetPowershellAsDefaultApplication will allow you to double click powershell files to execute them. 

Now in your windows file explorer just navigate to `C:\KaliCommands` and access the programs/tools in there.


More ideas:
```bash
wsl zsteg -e $file
wsl exiv2 $file
wsl exiftool $file
wsl foremost -i $file
wsl binwalk -e $file
wsl strings $file
```
