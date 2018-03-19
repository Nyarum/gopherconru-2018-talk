package main

import (
	"fmt"
	"time"
)

func collector(ch1 chan int) {
	for i := 0; i < 10000000; i++ {
		ch1 <- i
	}
	close(ch1)
}

func main() {
	ch1 := make(chan int)
	go collector(ch1)

	var (
		sum   int
		start = time.Now()
	)
	for v := range ch1 {
		sum += v
	}

	fmt.Printf("Finished since - %vms, sum - %d\n", time.Now().Sub(start).Nanoseconds()/1000000, sum)
}
