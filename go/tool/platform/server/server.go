package server

import (
	"fmt"

	"github.com/valyala/fasthttp"
	"gitlab.weibo.cn/content_products/xiaoyu45/platform/dao"
)

func RequestHandler(ctx *fasthttp.RequestCtx) {
	ctx.SetContentType("application/json; charset=utf-8")
	result := dao.HandlerApi(ctx)
	n, err := ctx.Response.BodyWriter().Write(result)
	if err != nil {
		fmt.Printf("%s", err.Error())
		return
	}

	fmt.Printf("%d", n)
}
