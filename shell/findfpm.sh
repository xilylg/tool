#!/bin/bash
echo $1
#if [ !$1 ]; then
#   echo "keyword is empty"
#   exit
#fi

findname={}
containernames=("article_php" "wenda_php")
for ip in "10.93.31.160" "10.93.31.161" "10.93.31.162" "10.93.31.163" "10.93.31.164" "10.93.31.165" "10.93.31.166" "10.93.31.167" "10.93.31.168" "10.131.8.105" "10.131.8.131" "10.131.8.165" "10.131.8.7" "10.131.9.111" "10.131.9.212" "10.131.9.53" "10.131.9.64"
do
echo $ip
ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} -t "echo hello exit"
ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} -t << CODE
    containerid=""
    for name in ${containernames[@]}
    do
       if [ !$findname[$name] ]; then 
           containerid = `sudo docker ps |grep ${name}|awk '{print $1}'`
           contianername = ${name}
           findname[$name] = 1
       fi
    done

    echo $containerid
    if [ !$containerid ]; then
       echo "not exists\n"
       exit 
    fi

    result=`sudo docker exec  -it ${containerid} /bin/bash -c 'grep $1 /etc/php-fpm.d/env.conf'`
    if [ $result ]; then
        echo "(${contianername})\n"
        echo $result
    fi
    exit
CODE
done

