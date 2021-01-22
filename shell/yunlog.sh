#!/bin/bash
useage()
{
	echo -e "just help \e[1mtest\e[0m"
        echo -e 'Help:
           \e[1marticle_php[0m "grep '2080409995' /data1/app/article.card.weibo.com/applogs/commlog/publish_upload_all_20210106.log"
	   \e[1mwenda_php[0m ""
        '
}

wenda_php=("10.93.31.168" "10.131.8.131" "10.131.9.212")
article_php=("10.93.31.166" "10.93.31.164" "10.131.9.111" "10.131.8.165" "10.93.31.162")
ips=(["wenda_php"]=${wenda_php[@]} ["article"]=${article_php[@]})
case $1 in
      h)
      useage 
      ;;
      *)
	      echo $1
       for ip in ${ips[$1][@]}
       do
         echo $ip
        echo `ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} "$2"`
       done
       echo "OK"
      ;;
esac

