#!/bin/zsh

SCROB_USERNAME=
vared -p "Enter your email: " SCROB_USERNAME
echo "$SCROB_USERNAME" > ~/.scrob

cd "$(dirname "$0")"

sudo cp -f ./com.jordansitkin.scrob.plist /Library/LaunchAgents;
sudo cp -rf ./ /Applications/scrob;
sudo launchctl load /Library/LaunchAgents/com.jordansitkin.scrob.plist;

exit;
