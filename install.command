#!/bin/bash

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}
user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

# get sudo access upfront
sudo -v

# check to see if there is an existing ~/.scrob file
overwrite=false
user "~/.scrob already exists, what do you want to do? [s]kip, [o]verwrite?"
read -n 1 action
case "$action" in
  o )
    overwrite=true;;
  s )
    overwrite=false;;
  * )
    ;;
esac

# if so, prompt to overwrite with given username
if [ "$overwrite" == "true" ] 
then
  rm ~/.scrob
  echo "---" > ~/.scrob
  user " - Enter your email:"
  read -e SCROB_USERNAME
  echo "email: $SCROB_USERNAME" >> ~/.scrob
fi


# then download zip from github into /Applications
# deflate it
# copy the LaunchAgent into place
# load up the LaunchAgent
# remove the zip file


# cd "$(dirname "$0")"
# sudo cp -f ./com.jordansitkin.scrob.plist /Library/LaunchAgents;
# sudo cp -rf ./ /Applications/scrob;
# sudo launchctl load /Library/LaunchAgents/com.jordansitkin.scrob.plist;

exit;
