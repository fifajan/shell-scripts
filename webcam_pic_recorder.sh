#! /bin/bash

DEVICE="/dev/video1"
TIMEOUT="1" # in seconds, between shots
QUALITY="92" # JPEG quality
RES="1920x1080"

while true; do
    TIMESTAMP="date +%Y.%m.%d-%Hh.%Mm.%Ss"
    streamer -w"$TIMEOUT" -c"$DEVICE" -fjpeg -j"$QUALITY" -s"$RES" -q -o"`$TIMESTAMP`".jpeg
done