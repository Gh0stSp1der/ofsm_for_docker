#!/bin/sh

while true;
do
	#echo "`date +%H:%M:%S` - `df | grep docker`" >> /tmp/df.log
	echo "`date +%H:%M:%S` - `df -Th | grep overlay2`" >> /tmp/df.log
	#df -Th / | tail -n 1 >> /tmp/df.log
	sleep 1
done
