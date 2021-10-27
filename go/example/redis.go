package example

import (
	"fmt"

	"github.com/gomodule/redigo/redis"
)

func GetBigKey() bool {
	c, err := redis.Dial("tcp", "10.41.11.25:6398")
	if err != nil {
		fmt.Println(err)
		return false
	}

	defer c.Close()

	_, err = redis.String(c.Do("GET", "112_filters_tabs"))
	if err != nil {
		fmt.Println(err)
		return false
	}

	return true
}
