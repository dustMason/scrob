scrob
=====

> Sends info about music you play in iTunes on your mac to our top secret collection facility.

To install, open up a terminal window and paste in this line:

    bash <(curl -s https://raw.github.com/dustMason/scrob/master/install.command)

You will be asked for your email - this will identify you on the website.

A 'scrob' folder will be created in `/Applications`, and a LaunchAgent plist file will be added to ~/Library/LaunchAgents. The script is scheduled to run every 12 hours. Running the `uninstall.command` found in that folder removes all installed files and kills the background process.
