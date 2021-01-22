#!/bin/bash
#for ip in "10.93.31.160" "10.93.31.161" "10.93.31.162" "10.93.31.163" "10.93.31.164" "10.93.31.165" "10.93.31.166" "10.93.31.167" "10.93.31.168" "10.131.8.105" "10.131.8.131" "10.131.8.165" "10.131.8.7" "10.131.9.111" "10.131.9.212" "10.131.9.53" "10.131.9.64" 
for ip in "10.93.31.160" "10.93.31.161" "10.93.31.163" "10.93.31.166"
do
echo $ip
#ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} -t "echo 'ok' exit"
ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} -t "echo 'curl newdcp.intra.weibo.com/tool/dcpTools -o dcpTools && chmod +x dcpTools && ./dcpTools' | sudo sh exit"
done	
