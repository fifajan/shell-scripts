#! /bin/sh

# Copy given file n times

COUNT=0

for F in "$@" ;
do
    EXT=".jpeg"
    FILENAME=`printf %08d $COUNT`
	mv "$F" "$FILENAME""$EXT"
    COUNT=$((COUNT+1))
done
