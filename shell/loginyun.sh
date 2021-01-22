#!/bin/bash

useage()
{
        echo 'Help:
        $1:
            wenda_data - 
            s - slave mysql
        $2:
            s_id - sticker_id from recommend
            photos - connect 3698
        '
}

case $1 in
    wenda_data)
        ip=10.93.31.161
    ;; 
    wenda_cron)
        ip=10.93.31.160
    ;;
    wenda_php)
        ip=10.93.31.166
    ;;
    zc)
	ip=10.93.31.161
    ;;
    mbus)
       ip=10.131.8.165
    ;;
    help)
        useage
    ;;
    *)
        ip=$1
    ;;
esac
ssh -i /Users/xiaoyu45/.ssh/privateKeyyun xiaoyu45@${ip}
