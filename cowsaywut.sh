#!/bin/bash

###############################################################
# Created by David Nuzik. Just for fun.                       #
#                                                             #
# This script requires cowsay, fortune, and lolcat packages   #
#                                                             #
###############################################################

## Todos:
## perform a check that the tty can handle colors (for lolcat)
## include argument to set speed of animations and set a var to specify lolcat speed

## Notes:
## lolcat default -s seped is 20. 40 is kinda fast 60 or more very fast.
## lolcat default -d (animation duration) is 12. Us 2 for better performance such as on a pi zero.
###############################################################

# Check that cowsay, lolcat, and fortune can be invoked
printf "\nChecking that all pre-reqs exist on PATH...\n\n" && sleep .5

## Declare function to check all pre-reqs
function which_check {
which $1 >/dev/null 2>&1

if [ $? -ne 0 ] #check for non-zero exit code (check if the package is not on path)
  then
    # is true, therefore the prereq is NOT on path (not good)
    echo "$prereq IS NOT ON PATH (NOT GOOD)."
    sleep .5
  else
    # is false, therefore the prereq is on path (good)
    echo "$prereq gave us a zero exit code... (this is good)."
    sleep .5
fi
}

## Invoke which_check function in a for loop for each prereq (package) we need
for prereq in cowsay fortune lolcat
  do
    echo "Checking $prereq..." && which_check $prereq && sleep 1
done

# temporary pause and EXIT 199 to express completion of for loop / function.
sleep 3
exit 199

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

