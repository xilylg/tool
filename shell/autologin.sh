#!/bin/bash
useage()
{
        echo 'Help:
        $1:
            weiping -
            web-photo -
            web-photo-product -
            pub_admin -
        '
}

dockermap=(["pub_admin"]="xiaoyu45_centos" ["web-photo"]="web-photo-test")
keyword=${dockermap[$1]}
echo $keyword
case $1 in
      h)
      useage 
      ;;

      *)
      dockerid=`sudo docker ps|grep -v grep|grep $keyword|awk '{print \$1}'|head -n1`
      echo $dockerid
      if [[ -z $dockerid ]]; then
           echo 'no exists' 
      else:
          `sudo docker exec -it ${dockerid} /bin/bash`
      fi
      ;;
esac
