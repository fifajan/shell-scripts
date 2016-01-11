#!/bin/sh

# dump all vCard contacts into single file

#echo "$1"
NAME=`echo "$1" | sed -re 's/^[^\/]*\/*(.*)\.[^.]*$/\1/'`
PHONE=`grep TEL "$1" | sed -re 's/^[^0-9\+]*([0-9\+]+).*$/\1/'`

echo $NAME $PHONE
