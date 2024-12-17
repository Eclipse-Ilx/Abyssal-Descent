REPO=$(shell pwd)
VERSION=$(shell echo "dev-0.1.0-$$(git rev-parse --short HEAD)")

default:
	@echo "No target specified"

.PHONY: build
build:
	-@mkdir -p build/mods
	cd "$(REPO)/src/dimthing" && INSTALL_DIR="$(REPO)/build/mods" make install
	cd "$(REPO)/src/adresources" && INSTALL_DIR="$(REPO)/build/mods" make install

.PHONY: install
install:
	-@mkdir -p build/mods
	awk 'BEGIN {FS = ","; RS = "\r?\n"} !/^#/ && NF { \
		cmd = "curl -sSLo \"build/mods/"$$1".jar\" \"https://www.curseforge.com/api/v1/mods/"$$2"/files/"$$3"/download""\""; \
		print cmd; system(cmd) }' mods.csv

.PHONY: copy
copy:
	-@mkdir -p build
	cp -r overrides/* build/

.PHONY: all
all: build install copy
	echo "$(VERSION)"> build/release.txt

.PHONY: export
export:
	@zip -r "Abyssal-Descent-$(VERSION).zip" build

.PHONY: clean
clean:
	-rm -r build
