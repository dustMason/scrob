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
new_account=false

api="whaleteeth.herokuapp.com"
# api="localhost:3000"

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


prompt_for_email_and_password () {

  rm -rf ~/.scrob
  mkdir -p ~/.scrob
  mkdir -p ~/.scrob/cached

  user "Do you already have a scrob account? [y]es, [n]o"
  read -n 1 action
  case "$action" in
    n )
      new_account=true;;
    N )
      new_account=true;;
    * )
      ;;
  esac

  echo "{" > ~/.scrob/config.json
  user " - Enter your email:"
  read -e SCROB_USERNAME
  echo "  \"email\": \"$SCROB_USERNAME\"," >> ~/.scrob/config.json
  user " - Enter your password:"
  read -e SCROB_PASSWORD
  echo "  \"password\": \"$SCROB_PASSWORD\"," >> ~/.scrob/config.json
  echo "  \"api\": \"$api\"" >> ~/.scrob/config.json
  echo "}" >> ~/.scrob/config.json
  info "Config saved. You can view/edit the config at ~/.scrob/config.yml"
  
  if [ "$new_account" == "true" ]
  then
    create_new_account "$SCROB_USERNAME" "$SCROB_PASSWORD"
  fi

}

create_new_account () {
  # $1 and $2 = email and password
  posted=`curl --data "email=$1&password=$2" -X POST --silent "http://$api/users"`
  if [ "$posted" == "success" ]
  then
    success "Account created"
  else
    info "There was an error ($posted), please try again"
    prompt_for_email_and_password
  fi
}

if [ "$overwrite" == "true" ] 
then
  prompt_for_email_and_password
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
