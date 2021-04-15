#!/bin/bash
containerid=`sudo docker ps |grep $1|awk 'BEGIN{FS=" "}{print $1;}'`
`sudo docker exec -it ${containerid} /bin/bash`
