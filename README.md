# Bluesky Quicklaunch
## The script itself
A quick and dirty script that allows you to pick from a group of select Bluesky machines you designate for faster access. First an AppleScript list opens showing your list of machines to choose. Once you've picked one, you can then pick if you want to SSH, VNC or SCP. From there, this script just calls the Bluesky Admin Connect tool with the correct URI scheme and encoded variables.

You can call the script directly with whatever you'd like (BTT, as a `.command`, Siri Shortcut (....someday ....soon). Or you could use a tool like Platypus or Automator to build an app that you can launch.

## Computer List

The computer list file can live a number of places but are checked for existance in this order:

* `~/.blueskyComputerList.txt` As a hidden file in the root of your home folder. This shuold be the easiest to manage.
* `./blueskyComputerList.txt` In the current working dir, handy if you're using Platypus to create an app, include the list in the `Resources` list (thus the list and script sit side-by-side)
* In the same directory as the script when it's called. This was mainly an attempt to get things to work with Platypus but it likes the above better. This works if you're just calling the script sitting in a folder...probably useless.

Entry formatting for the list is csv: `Friendly Machine Name,id#,username`

`Friendly Machine Name` is purely for how it will appear in the list.

`id#` is the bluesky ID number, as found in your admin page.

`username` is a username you'd like defaulted into the process. If not provided, bluesky admin will just ask you.

