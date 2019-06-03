package main

import (
	"log"
	"net/http"
	"path"
)

func IndexHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("Content Type", "text/html")
	http.ServeFile(w, r, path.Join(".", "static/index.html"))
}

func main() {
	http.HandleFunc("/", IndexHandler)
	if err := http.ListenAndServe(":3000", nil); err != nil {
		log.Fatal(err)
	}
}
