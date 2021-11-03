package test

import (
	"fmt"
	"testing"
	"xiaoyu45/example"
)

func TestGetBigKey(t *testing.T) {
	result := example.GetBigKey()
	fmt.Printf("%t", result)
}

func BenchmarkGetBigKey(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < 51; i++ {
		example.GetBigKey()
	}
}

func BenchmarkGetBaidu2(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		example.GetBaidu()
	}
}

func BenchmarkGetBaiduFastHttp(b *testing.B) {
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		example.GetBaiduFastHttp()
	}
}

func TestLogs(t *testing.T) {
	example.Logs()
}
