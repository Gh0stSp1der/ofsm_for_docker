#!/bin/sh

limit=10485760
path=`docker inspect $1 | grep -i MergedDir | awk -F ': ' '{print $2}' | awk -F '"' '{print $2}'`
src=`df --output=used $path | sed 1d`

while true;
do
	#echo "`date +%H:%M:%S` - `df -Th $path | grep overlay2`" >> /tmp/df.log
	#echo "`df --output=used $path | sed 1d`" >> /tmp/df.log
    curr=`df --output=used $path | sed 1d`
    curr_p=`echo | awk "{printf \"%.0f\", ($curr - $src) / $limit * 100}"`
    echo "$curr_p%" >> /tmp/df.log
	sleep 1
done
