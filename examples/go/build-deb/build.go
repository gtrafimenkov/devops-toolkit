// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

package main

import (
	"log"
	"os"

	"github.com/goreleaser/nfpm"
	_ "github.com/goreleaser/nfpm/deb"
)

func main() {
	name := "foo2"
	format := "deb"

	info := nfpm.Info{
		Arch:        "amd64",
		Platform:    "linux",
		Name:        name,
		Section:     "default",
		Priority:    "extra",
		Version:     "1.0.1",
		Maintainer:  "John Doe <john@example.com>",
		Vendor:      "John Doe Inc",
		Description: "FooBar is the great foo and bar software.\nAnd this can be in multiple lines!",
		Homepage:    "https://example.com",
		License:     "MIT",
		Bindir:      "/usr/local/bin",
		Overridables: nfpm.Overridables{
			Files: map[string]string{
				"foo.sh": "/usr/local/bin/foo2",
				"bar.sh": "/usr/local/bin/bar2",
			},
		},
	}

	if err := nfpm.Validate(info); err != nil {
		log.Fatalf("invalid nfpm config: %v", err)
	}

	packager, err := nfpm.Get(format)
	if err != nil {
		log.Fatalf("failed to get packager %v: %v", format, err)
	}

	path := name + "." + format
	w, err := os.Create(path)
	if err != nil {
		log.Fatalf("failed to create file %v: %v", path, err)
	}
	defer w.Close()
	if err := packager.Package(nfpm.WithDefaults(info), w); err != nil {
		log.Fatalf("failed to create package %v: %v", name, err)
	}
	if err := w.Close(); err != nil {
		log.Fatalf("failed to close the package file %v: %v", path, err)
	}
}
