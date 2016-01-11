#! /bin/sh

# Copy given file n times

for F in "$@" ;
do
	./randomize_name.sh "$F"
done
