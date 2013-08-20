scrob
=====

> Sends info about music you play in iTunes on your mac to our top secret collection facility.

To install, open up a terminal window and paste in this line:

    bash <(curl -s https://raw.github.com/dustMason/scrob/master/install.command)

You'll then be prompted for your Mac OS X user password so that the script can set up a background process which monitors iTunes. You will be asked for a username - this will identify you on the website.

A 'scrob' folder will be created in `/Applications`. Running the `uninstall.command` in there reverses these changes and kills the background process.
