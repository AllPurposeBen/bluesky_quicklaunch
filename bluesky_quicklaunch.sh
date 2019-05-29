#!/bin/bash

## Vars, lets get our stuff
if [[ -f "$HOME/.blueskyComputerslist.txt" ]]; then
	computersListPath="$HOME/.blueskyComputerslist.txt"
elif [[ -f "./blueskyComputerslist.txt" ]]; then
	computersListPath="./blueskyComputerslist.txt"
elif [[ -f "$(dirname $0)/blueskyComputerslist.txt" ]]; then
	computersListPath="$(dirname $0)/blueskyComputerslist.txt"  ## change this if you want
else
	echo "The list of computers needs to be in the same folder as this script for things to work."
	exit 3
fi

## Format the computer list for stupid AppleScript
computerNameListRaw=$(cat "$computersListPath" | awk -F ',' '{print $1}')
computerListOSA=''
IFS=$'\n'
for thisItem in $(echo "$computerNameListRaw"); do
	if [ "$computerListOSA" ]; then
		computerListOSA="$computerListOSA, \"$thisItem\""
	else
		computerListOSA="\"$thisItem\""
	fi
done

## Get what computer we want
computerChoice=$(osascript -e "choose from list {$computerListOSA} with title \"Pick a computer\" ok button name \"Select\"")
# handle a cancel
if [[ "$computerChoice" == 'false' ]]; then
	exit 1
fi

## Get the bluesky ID based on the human name of the computer
bsID=$(grep ^"$computerChoice" "$computersListPath" | awk -F ',' '{print $2}')
# sanity check that we have an integer value here
if [ ! "$bsID" -ge 1 ];then
	echo "Found a garbage value for bluesky ID."
	exit 4
fi

## Get a username from the list if we have one
username=$(grep ^"$computerChoice" "$computersListPath" | awk -F ',' '{print $3}')

## What are we going to do?
connectionType=$(osascript -e 'choose from list {"VNC","SSH","SCP"} ok button name "Connect"')
if [[ "$connectionType" == 'false' ]]; then
	exit 1
fi

## Set the url string 
if [[ -z "$username" ]]; then
	# no username found in list
	url="blueSkyID=$bsID&action=$connectionType"
else
	url="blueSkyID=$bsID&user=$username&action=$connectionType"
fi

## 3, 2, 1...do iiiit.
open bluesky://com.solarwindsmsp.bluesky.admin?"$url"

# bob's your uncle
exit 0