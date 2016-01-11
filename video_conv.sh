#! /bin/sh

for VID in "$@" ;
do
    ffmpeg -i "$VID" -acodec copy -vcodec mpeg4 -b 3000k "$VID".mp4
done
