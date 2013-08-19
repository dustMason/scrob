#!/bin/bash

info () {
  printf "\n  [ \033[00;34m..\033[0m ] $1"
}
user () {
  printf "\n\r  [ \033[0;33m?\033[0m ] $1 "
}
success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

# get sudo access upfront
sudo -v

overwrite=true

# check to see if there is an existing ~/.scrob file
if [ -f "$HOME/.scrob" ]
then
  # if so, prompt to overwrite with given username
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
fi

if [ "$overwrite" == "true" ] 
then
  rm -f ~/.scrob
  echo "---" > ~/.scrob
  user " - Enter your email:"
  read -e SCROB_USERNAME
  echo "email: $SCROB_USERNAME" >> ~/.scrob
fi


info "Downloading scrob"
# download zip from github into /Applications
# deflate it
# make scrob executable chmod +x

info "Installing LaunchAgent"
# copy the LaunchAgent into place
# sudo cp -f ./com.jordansitkin.scrob.plist /Library/LaunchAgents;
# load up the LaunchAgent
# sudo launchctl load /Library/LaunchAgents/com.jordansitkin.scrob.plist;

info "Cleaning up"
# remove the zip file

success "Done!"

# cd "$(dirname "$0")"
# sudo cp -rf ./ /Applications/scrob;

exit;
