#!/bin/sh

upper_path="/run/containerd/io.containerd.runtime.v2.task/k8s.io/"`kubectl describe pod qsh-pm-test | grep -i "Container id" | awk -F '/' '{print $3}'`"/rootfs"
date=$(date '+%Y-%m-%d_%H-%M-%S')
limit=10485760
#src=`kubectl exec -i $1 -- df --output=used / | sed 1d`
src=`df --output=used $upper_path | sed 1d`

while true;
do
    #curr=`kubectl exec -i $1 -- df --output=used / | sed 1d`
    curr=`df --output=used $upper_path | sed 1d`
    curr_p=`echo | awk "{printf \"%.0f\", ($curr - $src) / $limit * 100}"`
    echo "$curr_p%" >> /tmp/df.log
	sleep 1
done
