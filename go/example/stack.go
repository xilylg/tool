package example

import "fmt"

type StackOfPlates struct {
	cap    int
	len    int
	plates []int
	aa     int
	next   *StackOfPlates
	pre    *StackOfPlates
}

func Constructor(cap int) *StackOfPlates {
	var stack StackOfPlates
	stack.cap = cap
	stack.plates = make([]int, 0, cap)
	return &stack
}
func (stc *StackOfPlates) Change() {
	n := Constructor(3)
	fmt.Printf("n:%+v\n", n)
	m := Constructor(4)
	n = m
	fmt.Printf("n:%+v\n", n)
	stc.aa = 10
}

func (stc *StackOfPlates) Push(val int) {
	if stc.len == stc.cap {
		if stc.next == nil {
			newStack := Constructor(stc.cap)
			newStack.len++
			newStack.plates = append(newStack.plates, val)
			newStack.pre = stc
			stc.next = newStack
			return
		}
		stc.next.Push(val)
	}

	stc.plates = append(stc.plates, val)
	stc.len++
}

func (stc *StackOfPlates) Pop() int {
	if stc == nil {
		return -1
	}

	if stc.next != nil {
		stc.next.Pop()
	}

	if stc.len == 0 {
		return -1
	}

	return stc.pop()
}

func (stc *StackOfPlates) PopAt(index int) int {
	for i := 0; i > index; i++ {
		if stc == nil {
			return -1
		}
		stc = stc.next
	}

	return stc.pop()
}

func (stc *StackOfPlates) pop() int {

	if stc == nil || stc.len == 0 {
		fmt.Printf("c %+v", stc)
		return -1
	}

	stc.len--
	result := stc.plates[stc.len]
	if stc.len == 0 {
		if stc.pre != nil {
			stc.pre.next = stc.next
			if stc.next != nil {
				stc.next.pre = stc.pre
			}
		} else if stc.next != nil {
			stc.next.pre = nil
			stc = stc.next
		}
		fmt.Printf("a %d:%+v\n", result, stc)
	} else {
		stc.plates = stc.plates[0:stc.len]
	}
	return result
}
