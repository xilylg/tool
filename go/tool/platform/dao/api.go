package dao

import (
	"crypto/hmac"
	"crypto/sha1"
	"encoding/base64"
	"fmt"
	"log"
	"net/url"

	"github.com/valyala/fasthttp"
)

const apihost string = "i2.api.weibo.com"

func HandlerApi(requestCtx *fasthttp.RequestCtx) []byte {
	source := "379999222"
	loginUid := int64(2080409995)
	tauthToken, tauthTokenSecret := Tauth(source)
	c := &fasthttp.Client{}
	req := new(fasthttp.Request)

	querySring := string(requestCtx.Request.URI().QueryString())
	if querySring != "" {
		querySring = querySring + "&source=" + source
	} else {
		querySring = querySring + "?source=" + source
	}
	req.SetHost(apihost)
	req.URI().SetQueryString(querySring)
	req.URI().SetPath(string(requestCtx.URI().Path()))
	auth := authorization(loginUid, tauthToken, tauthTokenSecret)
	req.Header.Add("authorization", auth)
	resp := new(fasthttp.Response)
	err := c.Do(req, resp)
	if err != nil {
		fmt.Printf("%s", err.Error())
		return nil
	}
	if resp.Header.StatusCode() != fasthttp.StatusOK {
		return nil
		// log.Fatalf("Unexpected status code: %d. Expecting %d", statusCode, fasthttp.StatusOK)
	}

	if err != nil {
		log.Fatalf("Error when loading google page through local proxy: %s", err)
	}
	return resp.Body()
}

func authorization(loginUid int64, tauthToken, tauthTokenSecret string) string {
	param := fmt.Sprintf("uid=%d", loginUid)
	h := hmac.New(sha1.New, []byte(tauthTokenSecret))
	_, err := h.Write([]byte(param))
	if err != nil {
		return ""
	}

	s := string(h.Sum(nil))
	tauthSignature := base64.StdEncoding.EncodeToString([]byte(s))
	return `TAuth2 token="` + url.QueryEscape(tauthToken) + `",sign="` + url.QueryEscape(tauthSignature) + `",param="` + url.QueryEscape(param) + `"`
}
