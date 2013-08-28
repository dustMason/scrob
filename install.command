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
if [ -e "$HOME/.scrob" ]
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
  rm -rf ~/.scrob
  mkdir -p ~/.scrob
  mkdir -p ~/.scrob/cached
  echo "{" > ~/.scrob/config.json
  user " - Enter your email:"
  read -e SCROB_USERNAME
  echo "'email': '$SCROB_USERNAME'" >> ~/.scrob/config.json
  echo "}" >> ~/.scrob/config.json
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
launchctl unload ~/Library/LaunchAgents/com.jordansitkin.scrob.plist
rm -f ~/Library/LaunchAgents/com.jordansitkin.scrob.plist
cp -f ./scrob/com.jordansitkin.scrob.plist "$HOME/Library/LaunchAgents"
chmod 644 "$HOME/Library/LaunchAgents/com.jordansitkin.scrob.plist"
# load up the LaunchAgent
launchctl load "$HOME/Library/LaunchAgents/com.jordansitkin.scrob.plist"

info "Cleaning up"
rm -rf scrob.tar.gz

info "Running for the first time"
/Applications/scrob/scrob

success "Done!"

exit;
