package test

import (
	"fmt"
	"testing"

	"github.com/valyala/fasthttp"
	"gitlab.weibo.cn/content_products/xiaoyu45/platform/dao"
)

func TestTauth(t *testing.T) {
	dao.Tauth("379999222")
}

func TestApi(t *testing.T) {
	ctx := new(fasthttp.RequestCtx)
	ctx.Request.SetHost("http://127.0.0.1:8989")
	ctx.Request.URI().SetQueryString("ids=4680909388779548")
	ctx.Request.URI().SetPath("/2/statuses/show_batch.json")
	result := dao.HandlerApi(ctx)
	n, err := ctx.Response.BodyWriter().Write(result)
	if err != nil {
		fmt.Printf("%s", err.Error())
		return
	}
	fmt.Printf("n:%d\n", n)
}
