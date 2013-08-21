#!/bin/bash

launchctl unload ~/Library/LaunchAgents/com.jordansitkin.scrob.plist;
rm -f ~/Library/LaunchAgents/com.jordansitkin.scrob.plist;
rm -f ~/.scrob;

echo "Done!"

exit;
