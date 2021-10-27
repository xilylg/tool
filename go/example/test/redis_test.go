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
	for i := 0; i < b.N; i++ {
		example.GetBigKey()
	}
}
