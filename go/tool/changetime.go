package main

import "fmt"
import "time"

import "flag"

func main() {
	uids := []int{23, 2142}
	fmt.Printf("%+v", uids[0:10])
	var duration int64
	flag.Int64Var(&duration, "d", 111, "duration since 1885")
	flag.Parse()
	fmt.Println(duration)
	ss, _ := time.Parse("2006-01-02 15:04:05", "1885-01-01 00:00:00")
	fmt.Println(ss.Add(time.Duration(duration) * time.Second).Format("2006-01-02 15:04:05"))

	return
}
