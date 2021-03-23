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

declare -A prereq_check ## Associative array (map) is leveraged to store error messages for missing packages this can be simplified later into a simple array...

# Check that cowsay, lolcat, and fortune can be invoked
printf "\nChecking that all pre-reqs exist on PATH...\n\n" && sleep .5

## Declare function to check all pre-reqs
function which_check {

which $1 >/dev/null 2>&1

if [ $? -ne 0 ] #check for non-zero exit code (check if the package is not on path)
  then
    # is true, therefore the prereq is NOT on path (not good). Store error message in associative array to output to user later.
    prereq_check[$1]="$1 not on path (NOT GOOD)."
    sleep .25
fi
}

## Invoke which_check function in a for loop for each prereq (package) we need so we can store any errors in prereq_check associative array.
for prereq in cowsay fortune lolcat
  do
    echo "Checking that $prereq package is on PATH..." && which_check $prereq && sleep .5
done

# print any values (erors) stored in prereq_check i.f.f. the array has any
if [ ${#prereq_check[@]} -gt 0 ] # if the associative array is not empty then...
  then
    for i in "${!prereq_check[@]}" # for each entry in the array do...
      do
        if [ ! -z "${prereq_check[$i]}" ] # do this check, if an entry has a value then print it out to the user so they know which prereq packages they need before they can run the script.
          then 
          printf "${prereq_check[$i]}\n"
        fi
    done
    exit 222 # exit 222 to indicate 1 or more packages are missing
fi

# clear terminal window
sleep 1
clear

##############################################################
# Start the fun part of the script here if passed our checks #
##############################################################
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

