#!/bin/bash

sudo launchctl unload /Library/LaunchAgents/com.jordansitkin.scrob.plist;
sudo rm /Library/LaunchAgents/com.jordansitkin.scrob.plist;
sudo rm ~/.scrob;

exit;
