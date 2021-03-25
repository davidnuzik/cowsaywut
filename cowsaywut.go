package main

import (
	"fmt"
	"log"
	"os/exec"
)

func main() {
	fmt.Println("DEBUG: Entrypoint.")
	out, err := exec.Command("fortune").Output()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Your fortune is: %s\n", out)
}
