package dao

import (
	"log"
	"strings"

	"github.com/gomodule/redigo/redis"
)

type Token struct {
	TauthToken       string
	TauthTokenSecret string
}

// 2458194803.tauth_token="OXPRSVOWRVNQXNXONXOTQOTUSNWOXNXNXK@JwaEIOrI"
// 2458194803.tauth_token_secret="11263fb6354e3cebb2c2"

func Tauth(source string) (string, string) {
	cli, err := redis.Dial("tcp", "rs20338.hebe.grid.sina.com.cn:20338")
	if err != nil {
		panic(err)
	}
	authCacheKey := "tauth2token#" + source
	rec, err := cli.Do("Get", authCacheKey)
	if err != nil {
		log.Printf("redis error1(%v)", err)
		return "", ""
	}

	token, secret, err := parse(rec)
	if err != nil {
		log.Printf("redis error2(%v)", err)
		return "", ""
	}
	return token, secret
}

func parse(resp interface{}) (token, secret string, err error) {
	switch vv, ok := resp.([]byte); {
	case !ok:
	case vv != nil:
		tokens := strings.Split(string(vv), "\\t")
		if len(tokens) == 2 {
			token, secret = tokens[0], tokens[1]
		}
	}
	return
}
