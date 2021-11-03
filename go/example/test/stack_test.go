package test

import (
	"fmt"
	"testing"
	"xiaoyu45/example"
)

//["StackOfPlates", "push", "push", "push", "popAt", "popAt", "popAt"]
//[[2], [1], [2], [3], [0], [0], [0]]
func TestStack(t *testing.T) {
	obj := example.Constructor(2)
	obj.Push(1)
	obj.Push(2)
	obj.Change()
	fmt.Printf("q %+v,%[1]T\n", obj)
	obj.Push(3)
	param_0 := obj.PopAt(0)
	param_1 := obj.PopAt(0)
	fmt.Printf("d %+v", obj)
	param_2 := obj.PopAt(0)
	fmt.Printf("%d,%d,%d\n", param_0, param_1, param_2)
}
