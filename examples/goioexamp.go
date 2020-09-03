package main

import (
	"fmt"
	"io"
	"os"
)

func main() {
	pr, pw := io.Pipe()
	go func() {
		defer pw.Close()
		_, err := fmt.Println(pw, "Hello kalaiselvan!.")
		if err != nil {
			panic(err)
		}
		fmt.Println("sample")
		
	}()

	_,err:=io.Copy(os.Stdout, pr)

	if err != nil {
		panic(err)
	}
}
