package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/valyala/fasthttp"
	"gitlab.weibo.cn/content_products/xiaoyu45/platform/conf"
	"gitlab.weibo.cn/content_products/xiaoyu45/platform/server"
)

func main() {
	flag.Parse()
	if err := conf.Init(); err != nil {
		log.Printf("conf.Bootstrap() error(%v)", err)
		panic(err)
	}

	if err := fasthttp.ListenAndServe(conf.Conf.Addr, server.RequestHandler); err != nil {
		fmt.Printf("%s", err)
		log.Fatalf("Error in ListenAndServe: %s", err)
	}
}
