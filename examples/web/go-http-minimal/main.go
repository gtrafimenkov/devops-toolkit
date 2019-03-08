// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Request: URL=%s Query=%s\n", r.URL.Path, r.URL.Query())
}

func main() {
	addr := "localhost:8080"
	fmt.Printf("Listening on %s...\n", addr)
	fmt.Printf("Try something like %q\n", "curl localhost:8080/foo/bar?baz=12")
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(addr, nil))
}
