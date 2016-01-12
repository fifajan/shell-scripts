#!/bin/bash

# Script requires ImageMagick

# Script for resizing wallpapers.
# It resizes wallpaper images in the following way:
# 1. No proportions altering;
# 2. No side/bottom black borders in result;
# 3. Output picture is _exactly_ MY_RES_X x MY_RES_Y;
# 4. If needed image is cropped by cutting equal strings from top/bottom or left/rigth sides.

# Written by Alexey Ivchenko on Mar 24 2010

DEST_DIR="/home/user/img"

MY_RES_X="1920"
MY_RES_Y="1080"
MY_RES="$MY_RES_X"x"$MY_RES_Y"
MY_PROP=`echo "scale=4; $MY_RES_X/$MY_RES_Y" | bc`
# get my screen proportion

echo My screen proportion : $MY_PROP

for IMG in "$@" ;
do
	RES=`identify "$IMG" | sed -e \
		's/\(.*JPEG\ \)\([0-9]*[Xx][0-9]*\)\(\ .*\)/\2/'`
	# cut img's resolution from 'identify' utility output.
	
	if [ "$RES" = "$MY_RES" ]
	then
		echo Image of needed size. Doing noting.
		exit 0
	fi
		
	RES_X=`echo $RES | sed -e 's/\(^[0-9]*\)\(.*\)/\1/'`
	RES_Y=`echo $RES | sed -e 's/\(.*x\)\([0-9]*\)/\2/'`
	# get separate X and Y resolutions.

	echo '*****'
	echo Image : $IMG
	echo res   : $RES
	#echo res X : $RES_X
	#echo res Y : $RES_Y

	IMG_PROP=`echo "scale=4; $RES_X/$RES_Y" | bc`
	EXPR="$IMG_PROP>$MY_PROP"
	# this logical expression will be true if img is wider than my screen

	IMG_NAME=`basename "$IMG"`
	IMG_BMP="$DEST_DIR/$IMG_NAME.bmp"

	if [ `echo "$EXPR" | bc` = "1" ]
	then
		echo Image is wider than screen.
	
		SCALE="x$MY_RES_Y"		

		FACT=`echo "scale=4; $MY_RES_Y/$RES_Y" | bc`
		# get img's scale factor

		TRIM_X=`echo "(($RES_X*$FACT) - $MY_RES_X)/2" | bc`
		# get width of left/rigth trim string
			
		TRIM_1="+$TRIM_X+0"
		TRIM_2="-$TRIM_X+0"
		# get trimming strings for 'mogrify' utility
	else
		echo Image is higher than screen.

                SCALE="$MY_RES_X"

                FACT=`echo "scale=4; $MY_RES_X/$RES_X" | bc`
                # get img's scale factor

                TRIM_Y=`echo "(($RES_Y*$FACT) - $MY_RES_Y)/2" | bc`
                # get width of top/bottom trim string

                TRIM_1="+0+$TRIM_Y"
                TRIM_2="+0-$TRIM_Y"
                # get trimming strings for 'mogrify' utility
	fi

	convert "$IMG" -scale $SCALE "$IMG_BMP"

        mogrify -crop $TRIM_1 "$IMG_BMP"
        mogrify -crop $TRIM_2 "$IMG_BMP"
        # trim img

        convert "$IMG_BMP" -quality 95 "$DEST_DIR/$IMG_NAME"
        # convert img back to jpeg

        rm "$IMG_BMP"

	echo Done!
done
