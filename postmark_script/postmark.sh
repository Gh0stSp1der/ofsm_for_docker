#!/bin/sh

## 1. Initialization
date=$(date '+%Y-%m-%d_%H-%M-%S')
log_home="/root/ofsm_for_docker/postmark_log"
log_dir="$log_home/$date"
mkdir -p $log_dir

## 2. Copy the configuration of the postmark benchmark tool to docker
docker cp /root/ofsm_for_docker/postmark_script $1:/root/postmark/

## 2-1. Copy the same configuration to the log directory for checking later
docker cp $1:/root/postmark/postmark_script/post.conf "$log_dir/post.conf"
#cp /root/ofsm_for_docker/postmark_script/post.conf "$log_dir/post.conf"

## 2-2. Clear garbage files to docker
docker exec -it $1 rm -rf /root/postmark/file/*

## 3. Clear previously running processes
pkill iostat
pkill get_df2

## 3-1. Clear log files
rm -rf /tmp/*.log

## 4. Execute resource collection scripts
iostat -mtx 1 -p > /tmp/iostat.log &
/root/ofsm_for_docker/postmark_script/get_df2.sh $1 &

echo "1. Start PostMark Test."
sleep 1
echo -n "3.."
sleep 1
echo -n "2.."
sleep 1
echo -n "1.."
sleep 1
echo "Start!!"
sleep 1

## 5. Execute postmark
docker exec -it $1 /root/postmark/postmark_script/postmark /root/postmark/postmark_script/post.conf > result.txt

## 6. Clear resource collection scripts
sleep 10
pkill iostat
pkill get_df2

## 6-1. Move log and result files to log directory
mv /tmp/*.log $log_dir/
mv result.txt $log_dir/

## 7. Sort collected log
cp /root/ofsm_for_docker/postmark_script/graph.sh $log_dir/
cd $log_dir
./graph.sh
