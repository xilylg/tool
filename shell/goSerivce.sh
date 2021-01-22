#!/bin/bash
project_root=/Users/xiaoyu45/GoLang/src/goService/app

case $1 in
	start)
            go build -o ${project_root}/interface/photo/bin/xxy_sticker_main ${project_root}/interface/photo/cmd/main.go
            ${project_root}/interface/photo/bin/xxy_sticker_main --conf=${project_root}/interface/photo/cmd/interface-main-local.toml&
            go build -o ${project_root}/service/sticker/bin/xxy_sticker_stickerService ${project_root}/service/sticker/cmd/main.go
            ${project_root}/service/sticker/bin/xxy_sticker_stickerService --conf=${project_root}/service/sticker/cmd/service-sticker-local.toml&
            ;;
        stop)
            pids=`ps -ef|grep xxy_sticker|grep -v grep|awk 'BEGIN{FS="    "}{if($2~/[0-9]*/&&$2!~/:/){print $2}}'`
	    for pid in $pids
            do
		   sudo kill $pid
            done
            ;;
esac
