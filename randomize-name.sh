#! /bin/bash

# This script renames file to random name keeping extention if present.

FILE="$1"
NAME=`basename "$FILE"`
DIR=`dirname "$FILE"`

if [ -d "$FILE" ] # if it is directory
then
	exit 0
fi
 
if [ -n "`echo "$NAME" | sed -n '/\./p'`" ] # if extention is present
then
	EXT=`echo "$NAME" | sed -e 's/\(^.*\)\(\.[^\.]*$\)/\2/'`
fi

UUID=`uuidgen`
RESNAME="$UUID""$EXT"

#echo $RESNAME

mv "$FILE" "$DIR/$RESNAME"
