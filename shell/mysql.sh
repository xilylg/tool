#!/bin/bash
useage()
{
	echo 'Help:
	$1:
	    m - master mysql
	    s - slave mysql
	$2:
	    s_id - sticker_id from recommend 
	    photos - connect 3698 
	    media - topweibo user_timeline
	    wenda - wenda database
	    wenda_log - wenda log database
	$3:
	   $ouid - topweibo user_timeline ouid
	'
}

master_database()
{
	case $1 in
	      s_id)
		      mysql -hm3698i.eos.grid.sina.com.cn -P3698 -uphotos_new -p4edea2f94ddd5be -Dphotos -e 'select * from recommend where `key`="STICKER_ID"\G'
		      ;;
	      photos)
		      mysql -hm3698i.eos.grid.sina.com.cn -P3698 -uphotos_new -p4edea2f94ddd5be -Dphotos
		      ;;
	      media)
		      mysql -hm5040i.randa.grid.sina.com.cn -P5040 -p99137a6f712a621 -uw_topweibo -Dtopweibo -e "select * from we_media where flag=0 and uid=$2"
		      ;;
	      wenda)
		      mysql -hm4318i.eos.grid.sina.com.cn -P4318 -p4612ea88a78e3e7 -uwenda -Dwenda  --default-character-set=latin1
		      ;;
	      wenda_log)
		      mysql -hm4318i.eos.grid.sina.com.cn -P4318 -p18376e4959d90af -uwenda_log -Dwenda_log  --default-character-set=latin1
		      ;;
              data_article)
		      mysql -hm4315i.eos.grid.sina.com.cn -P4315 -p0e3a96560df0f73 -udata_article -Ddata_article --default-character-set=latin1
		      ;;
	      article)
		      mysql -hm4313i.eos.grid.sina.com.cn -P4313 -pf3u4w8n7b3h -uarticle -Darticle  --default-character-set=latin1
		      ;;
	      zhongce)
                      mysql -hm9774i.eos.grid.sina.com.cn -P9774 -pdf7453540b00d5d -uzhongce -Dzhongce
                      ;;
	      esac
}

slave_database()
{
	case $1 in
		s_id)
			mysql -hs3698i.eos.grid.sina.com.cn -P3698 -uphotos_new_r -p87d368a219fe884 -Dphotos -e 'select * from recommend where `key`="STICKER_ID"\G'
			;;
		photos)
                        mysql -hs3698i.eos.grid.sina.com.cn -P3698 -uphotos_new_r -p87d368a219fe884 -Dphotos
			;;
		media)
			mysql -hs5040i.randa.grid.sina.com.cn -P5040 -p7a370c29906d1f0 -uw_topweibo_r -Dtopweibo -e "select * from we_media where flag=0 and uid=$2"
			;;
		wenda)
			mysql -hs4318i.eos.grid.sina.com.cn -P4318 -p75664c55994baa6 -uwenda_r -Dwenda --default-character-set=latin1
			;;
		wenda_log)
			mysql -hs4318i.eos.grid.sina.com.cn -P4318 -pc54c2fca84642fc -uwenda_log_r -Dwenda_log  --default-character-set=latin1
			;;
	        data_article)
			mysql -hs4315i.eos.grid.sina.com.cn -P4315 -p3bc4132ab256046  -udata_article_r -Ddata_article --default-character-set=latin1
			;;
		article)
			mysql -hs4313i.eos.grid.sina.com.cn -P4313 -pDAKAdfad3k4lzx -uarticle_r -Darticle  --default-character-set=latin1
			;;
		zhongce)
			mysql -hs9774i.hebe.grid.sina.com.cn -P9774 -p5e0579cda2af491 -uzhongce_r -Dzhongce
			;;
	esac
}

case $1 in
	m)
		master_database $2 $3
		;;
	s)
		slave_database $2 $3
		;;
	*)
		useage
		;;
esac

