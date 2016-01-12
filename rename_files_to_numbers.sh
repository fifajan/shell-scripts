#! /bin/sh

# Copy given file n times

COUNT=0

for F in "$@" ;
do
    FILENAME=`printf %08d $COUNT`
	mv "$F" "$FILENAME"
    COUNT=$((COUNT+1))
done
