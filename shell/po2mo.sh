#!/bin/bash
en="en-us.po"
tw="zh-hk.po"
path="/Users/xiaoyu45/data1/weiping/application/config/languages/"
echo $1
if [ $1 ] ; then
    path=$1
fi

us_target="${path}en_US/LC_MESSAGES/en-us.mo"
tw_target="${path}en_US/LC_MESSAGES/zh-tw.mo"
hk_target="${path}en_US/LC_MESSAGES/zh-hk.mo"

hk_source="${path}zh-hk.po"
en_source="${path}en-us.po"

echo ${hk_source}
echo  ${tw_target}
`msgfmt ${hk_source} -o ${tw_target}`
`cp ${tw_target} ${hk_target}`
`msgfmt ${en_source} -o ${us_target}`
