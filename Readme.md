scrob
=====

> Sends info about music you play in iTunes on your mac to our top secret collection facility.

To install, open up a terminal window and paste in this line:

    bash <(curl -s https://raw.github.com/dustMason/scrob/master/install.command)

When running the install for the first time, answer no when asked if you already have an account. You'll be asked for your email and will also need to choose a password.

A 'scrob' folder will be created in `/Applications`, and a LaunchAgent plist file will be added to ~/Library/LaunchAgents. The script is scheduled to run every 24 hours. Running the `uninstall.command` found in that folder removes all installed files and kills the background process.

Using the email and password you entered during the install, you can sign in to http://whaleteeth.herokuapp.com to browse everyone else's listening activity.
