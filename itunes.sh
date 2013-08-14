#!/bin/bash

current_track_name(){
	osascript <<-PPLESCRIPT
	tell application "iTunes"
		set res to (the name of current track as string)
	end tell
	PPLESCRIPT
}

current_artist_name(){
	osascript <<-PPLESCRIPT
	tell application "iTunes"
		set res to (the artist of current track as string)
	end tell
	PPLESCRIPT
}

current_track_rating(){
	osascript <<-PPLESCRIPT
	tell application "iTunes"
		set res to (the rating of current track as string)
	end tell
	PPLESCRIPT
}

current_album_name(){
	osascript <<-PPLESCRIPT
	tell application "iTunes"
		set res to (the album of current track as string)
	end tell
	PPLESCRIPT
}

check_if_itunes_is_running(){
	osascript <<-PPLESCRIPT
    tell application "System Events" to (name of processes) contains iTunes
	PPLESCRIPT
}


check_itunes(){
  syslog -s -l info "Checking iTunes..."
	is_open=`osascript -e 'tell application "System Events" to (name of processes) contains "iTunes"'`;
	if [ $is_open = "true" ]; then
    state=`osascript -e 'tell application "iTunes" to player state as string'`;
    if [ $state = "playing" ]; then
      send_scrobble
    fi
	fi
}

get_credentials(){
  cat ~/.scrob
}

send_scrobble(){
  local current_track_name=`current_track_name`
  local current_artist_name=`current_artist_name`
  local current_album_name=`current_album_name`
  local current_track_rating=`current_track_rating`
  local creds=`get_credentials`
  syslog -s -l info "Scrobbling for $creds"
  curl -i -X POST --data 'username='"$creds"'&title='"$current_track_name"'&artist='"$current_artist_name"'&album='"$current_album_name"'&rating='"$current_track_rating"'' "http://dizouble.com/music"
}

check_itunes;
