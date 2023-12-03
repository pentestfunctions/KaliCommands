$wslScript = "if [ ! -f ~/Paramfinder.py ]; then wget https://raw.githubusercontent.com/pentestfunctions/paramfinder/main/paramfinder.py -O ~/Paramfinder.py; fi; python3 ~/Paramfinder.py"
wsl bash -c $wslScript
