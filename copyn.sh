#! /bin/sh

# Copy given file n times

ORIG_FILE="$1"
N_COPIES="$2"
BASENAME=`basename "$ORIG_FILE"`

COUNT="0"
while [ $COUNT -le $N_COPIES ] ;
do
	COUNT=`echo "$COUNT + 1" | bc`
	NAME="$BASENAME"'-'`printf '%05i' $COUNT`
	echo $NAME
	cp "$BASENAME" "$NAME"
done ;
