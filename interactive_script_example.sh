#!/usr/bin/expect -f

send "Hint. sshgate nzhmuk ... \n"
send "Some hints/help can be typed \n"
send "here \n"
send "\n"
spawn ssh <user>@<host>
expect "<user>@<host>'s password: "
send <password>
interact
