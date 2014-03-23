#!/bin/sh
ps -e|grep bird_launch.sh && exit
mkdir $HOME/.bird
cd $HOME/.bird
test -e bird.ogg || wget http://zhuoweizhang.net/csc190/bird.ogg
test -e bird_launch.sh || wget http://zhuoweizhang.net/csc190/bird_launch.sh
test -e bird.html || wget http://zhuoweizhang.net/csc190/bird.html
test -e bird.sh || wget http://zhuoweizhang.net/csc190/bird.sh
chmod +x bird_launch.sh
chmod +x bird.sh
grep "bird.sh" ~/.bashrc || echo "~/.bird/bird.sh" >>~/.bashrc
./bird_launch.sh
