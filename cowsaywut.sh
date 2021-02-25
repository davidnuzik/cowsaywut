#!/bin/bash

###############################################################
# Created by David Nuzik. Just for fun.                       #
#                                                             #
# This script requires cowsay, fortune, and lolcat packages   #
# Intended for use on distros that use apt (apt-get)          #
###############################################################

## Todos:
## add logic to ensure have pre-reqs (all packages used)
## include argument to set speed of animations and set a var to specify lolcat speed

## Notes:
## lolcat default -s seped is 20. 40 is kinda fast 60 or more very fast.
## lolcat default -d (animation duration) is 12. Us 2 for better performance such as on a pi zero.
###############################################################

# clear terminal window
clear
sleep .3

# printf the intro and use lolcat.
printf "\n   __________ _       _______ _____  __   _       ____  ___________ \n  / ____/ __ \ |     / / ___//   \ \/ /  | |     / / / / /_  __/__ \ \n / /   / / / / | /| / /\__ \/ /| |\  /   | | /| / / / / / / /   / _/ \n/ /___/ /_/ /| |/ |/ /___/ / ___ |/ /    | |/ |/ / /_/ / / /   /_/  \n\____/\____/ |__/|__//____/_/  |_/_/     |__/|__/\____/ /_/   (_)   \n                                                                   \n" | lolcat -a -s 40 -d 4

# cowsay intro line (perhaps later can pick from a list of lines to say)
echo "This is an effective use of my time." | cowsay -t | lolcat -a -s 40 -d 2
printf "\n \n"
echo "Press CTRL+C at any time to stop."
sleep 1
echo "Press CTRL+C at any time to stop.."
sleep 1
echo "Press CTRL+C at any time to stop..."
sleep 2
clear

# start looping fortunes and don't stop until interrupted.
while true
do
	clear
	echo `date`
	printf "\n   __________ _       _______ _____  __   _       ____  ___________ \n  / ____/ __ \ |     / / ___//   \ \/ /  | |     / / / / /_  __/__ \ \n / /   / / / / | /| / /\__ \/ /| |\  /   | | /| / / / / / / /   / _/ \n/ /___/ /_/ /| |/ |/ /___/ / ___ |/ /    | |/ |/ / /_/ / / /   /_/  \n\____/\____/ |__/|__//____/_/  |_/_/     |__/|__/\____/ /_/   (_)   \n                                                                   \n" | lolcat
	fortune -s | cowsay -s | lolcat -a -s 40 -d 2
	sleep 10
done

exit 0

