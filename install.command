#!/bin/bash

info () {
  echo ""
  printf "  [ \033[00;34m..\033[0m ] $1 "
}
user () {
  echo ""
  printf "  [ \033[0;33m?\033[0m ] $1 "
}
success () {
  echo ""
  printf "\033[2K  [ \033[00;32mOK\033[0m ] $1 "
}

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
echo ""
cd "/Applications"
rm -rf scrob
curl -o scrob.tar.gz -L -# https://github.com/dustMason/scrob/archive/master.tar.gz
tar xpf scrob.tar.gz
mv ./scrob-master ./scrob
chmod +x ./scrob/scrob

info "Installing LaunchAgent"
# copy the LaunchAgent into place
cp -f ./scrob/com.jordansitkin.scrob.plist "$HOME/Library/LaunchAgents"
# load up the LaunchAgent
launchctl load "$HOME/Library/LaunchAgents/com.jordansitkin.scrob.plist"

info "Cleaning up"
rm -rf scrob.tar.gz

success "Done!"


exit;
