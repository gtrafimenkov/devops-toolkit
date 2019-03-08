// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Request: URL=%s Query=%s Vars=%v\n",
		r.URL.Path, r.URL.Query(), mux.Vars(r))
}

func main() {
	addr := "localhost:8080"
	fmt.Printf("Listening on %s...\n", addr)
	fmt.Printf("Try something like %q\n", "curl localhost:8080/foo/bar?baz=12")
	router := mux.NewRouter()
	router.Methods("GET").Path("/foo/{name}").HandlerFunc(handler)
	http.Handle("/", router)
	log.Fatal(http.ListenAndServe(addr, nil))
}
