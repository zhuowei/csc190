#!/bin/sh
while true
do
    sleep 300
    pactl set-sink-volume 0 65536 >/dev/null
    pactl set-sink-mute 0 false >/dev/null
    firefox -chrome bird.html
done
