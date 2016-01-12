#! /bin/sh

cd /dir/with/images/

for i in ./*.tif;
do cjb2 $i ~/djvu/$i.djvu;
done
