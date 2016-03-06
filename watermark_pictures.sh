#! /bin/bash

### Requires ImageMagick`s 'composite' util

EXT=".jpg"
COUNT=1
WATERMARK_IMG="./wat_mark.png" # good idea to make it transparent PNG
GRAVITY="SouthEast"

for F in "$@" ;
do
    FILENAME=`printf %08d $COUNT`

    composite -gravity "$GRAVITY" "$WATERMARK_IMG" "$F" output.jpg    
    mv output.jpg "$FILENAME""$EXT"
    COUNT=$((COUNT+1))
done

