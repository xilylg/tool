#!/bin/bash
useage()
{
        echo 'Help:
        $1:
            wenda_php -
            wenda_data -
            article_php -
            article_data -
            wenda_php - 
            article_php  -
            node_trigger - 
        $2:
            cron 
        '
}


ips=("10.93.31.160" "10.93.31.161" "10.93.31.162" "10.93.31.163" "10.93.31.164" "10.93.31.165" "10.93.31.166" "10.93.31.167" "10.93.31.168" "10.131.8.105" "10.131.8.131" "10.131.8.165" "10.131.8.7" "10.131.9.111" "10.131.9.212" "10.131.9.53" "10.131.9.64")
for ip in ${ips[@]}
do
echo $ip

if [[ $1 == "node_trigger" ]]; then
    find=`ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} "sudo ps -ef|grep -v grep|grep node_trigger|awk '{print $9}'|head -n1"`
else
    find=`ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} "sudo ps -ef|grep -v grep|grep php-fpm|awk '{print \\$10}'|head -n1"`
fi
echo $find

if [[ $2 ]] && [[ $2 == "cron" ]]; then
    if [[ -n $find ]]; then
        continue
    fi
else
    if [[ -z $find ]]; then
        continue
    fi
fi

find=`ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} "sudo docker ps|grep $1|awk '{print \\$1}'"`
echo $find

if [ $find ]; then
  ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} -tt "sudo docker exec -it ${find} /bin/bash"
  break
fi
done
