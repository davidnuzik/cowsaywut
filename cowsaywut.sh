#!/bin/bash

###############################################################
# Created by David Nuzik. Just for fun.                       #
#                                                             #
# This script requires cowsay, fortune, and lolcat packages   #
#                                                             #
###############################################################

## Todos:
## include argument to set speed of animations and set a var to specify lolcat speed

## Notes:
## lolcat default -s seped is 20. 40 is kinda fast 60 or more very fast.
## lolcat default -d (animation duration) is 12. Us 2 for better performance such as on a pi zero.
###############################################################

###############################################################
# Pre-req checks (check for needed packages else exit)        #
###############################################################

# Check that cowsay, lolcat, and fortune can be invoked
declare -A prereq_check ## Associative array (map) is leveraged to store error messages for missing packages this can be simplified later into a simple array...

printf "\nChecking that all pre-reqs exist on PATH and that the TERM supports at least 8 colors...\n\n" && sleep .5

## Declare function to check all pre-reqs
function which_check {

which $1 >/dev/null 2>&1

if [ $? -ne 0 ] #check for non-zero exit code (check if the package is not on path)
  then
    # is true, therefore the prereq is NOT on path (not good). Store error message in associative array to output to user later.
    prereq_check[$1]="$1 not on path or checking with the which command failed."
    sleep .25
fi
}

## Invoke which_check function in a for loop for each prereq (package) we need so we can store any errors in prereq_check associative array.
for prereq in cowsay fortune lolcat
  do
    echo "Checking that $prereq package is on PATH..." && which_check $prereq && sleep .5
done

## print any values (erors) stored in prereq_check i.f.f. the array has any
if [ ${#prereq_check[@]} -gt 0 ] # if the associative array is not empty then...
  then
    for i in "${!prereq_check[@]}" # for each entry in the array do...
      do
        if [ ! -z "${prereq_check[$i]}" ] # do this check, if an entry has a value then print it out to the user so they know which prereq packages they need before they can run the script.
          then 
          printf "${prereq_check[$i]}\n"
        fi
    done
    exit 111 # exit 111 to indicate 1 or more packages are missing
fi

# Check if the TERM supports enough colors for lolcat. If not just warn and ask the user if they want to continue anyway.
# We do this because most modern shells support 256 or more colors even if not reported as such with `tput colors` output.

## Do `tput colors` check here. If the check fails (non-zero exit code), then prompt the user if they want to continue.
colors=`tput colors`
if [ $? -ne 0 ] #check if the tput colors command gave us a non-zero exit code, if so TERM may not be defined but color may still work.
  then
    read -r -p "We got an error when using tput to check terminal color support. Continue? [y/n] " input
      case $input in
        [yY][eE][sS]|[yY])
      echo "Continuing anyway..."
      sleep 1
      ;;
        [nN][oO]|[nN])
      echo "Exiting..."
      sleep 1
      exit 112
      ;;
      *)
      echo "Invalid input..."
      exit 113
      ;;
      esac
  else
    # Else (the tput colors command succeeded with a zero exit code), assume the data in $colors is a number and do the following check
    # Ensure the $colors value is a value of -1 or that it is a value of 8 or greater. We assume here -1 will support colors.
    if [ $colors = -1 ] || [ $colors -gt 7 ]
      then
        echo "Confirmed TERM supports at least 8 colors."
	sleep 1
      else
        read -r -p "We got output from tput colors which seems to indicate the TERM does not support at least 8 colors. Continue? [y/n] " input
	  case $input in
	    [yY][eE][sS]|[yY])
	  echo "Continuing anyway..."
	  sleep 1
	  ;;
	    [nN][oO]|[nN])
	  echo "Exiting..."
	  exit 114
	  ;;
          *)
          echo "Invalid input..."
	  exit 115
	  ;;
          esac
    fi
fi

# Clear screen
sleep 1
clear


###############################################################
# Start the fun part of the script here if passed our checks  #
###############################################################
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

