#!/bin/bash

useage()
{
    echo 'Help
    $1:
        sticker_redis - connect rm21532
        s_info - sticker_info camera/sourceApi.json sticker $2 = 20190905
        f_info - filter_info camera/sourceApi.json filter
	test_s_info - dev sticker_info $2 = 20200102
	test_f_info - dev filter_info
        s_version - sticker_version tuding/getVersion.json sticker version
        f_version - filter_version tuding/getVersion.json filter version
        media - topweibo user_timeline
        other value - show useage
     $2:
        $ouid - media topweibo user_timeline ouid     
	'
}

case $1 in 
     s_info)
    	     redis-cli -h rm21532.hebe.grid.sina.com.cn -p 21532 get sticker_family_mapping_bar:$2>sticker_info.log
	     cat /usr/home/xiaoyu45/scripts/sticker_info.log|jq
	     ;;
     f_info)
	     redis-cli -h rm21532.hebe.grid.sina.com.cn -p 21532 lrange 110_filter_list 0 -1
	     ;;
     test_s_info)
             redis-cli -h 10.41.11.25 -p 6398 get sticker_family_mapping_bar:$2>test_sticker_info.log
	     cat /usr/home/xiaoyu45/test_sticker_info.log|jq
             ;;
     test_f_info)
	     redis-cli -h 10.41.11.25 -p 6398 lrange 110_filter_list 0 -1
	     ;;
     s_version)
	     redis-cli -h rm21532.hebe.grid.sina.com.cn -p 21532 hgetall sticker_bar:map 
	     ;;
     f_version)
	     redis-cli -h rm21532.hebe.grid.sina.com.cn -p 21532 hgetall filter_bar:map
	     ;;
     sticker_redis)
	     redis-cli -h rm21532.hebe.grid.sina.com.cn -p 21532
	     ;;
     media)
	     redis-cli -h rm7018.eos.grid.sina.com.cn -p 7018 zrevrange we_media_art_onew_$2_1 0 -1
	     ;;
     *)
         useage
	 ;;
esac
