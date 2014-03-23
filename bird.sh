#!/bin/sh
killall bird_launch.sh
mkdir $HOME/.bird
cd $HOME/.bird
test -e bird.ogg || wget http://zhuoweizhang.net/csc190/bird.ogg
test -e bird_launch.sh || wget http://zhuoweizhang.net/csc190/bird_launch.sh
test -e bird.html || wget http://zhuoweizhang.net/csc190/bird.html
chmod +x bird_launch.sh
./bird_launch.sh
