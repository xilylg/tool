function useage
{
        echo -e "just help \e[1mtest\e[0m"
        echo -e 'Help:
           \e[1marticle_php[0m "grep '2080409995' /data1/app/article.card.weibo.com/applogs/commlog/publish_upload_all_20210106.log"
           \e[1mwenda_php[0m ""
        '
}

ips=("10.131.8.105" "10.131.8.7" "10.131.9.53" "10.131.9.64" "10.133.72.155" "10.133.72.219" "10.73.13.239" "10.93.31.162" "10.93.31.166")
case $1 in
      h)
      useage
      ;;
      *)
       for ip in ${ips[@]}
       do
         echo $ip
         echo `ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip} "$2"`
       done
       echo "OK"
      ;;
esac
