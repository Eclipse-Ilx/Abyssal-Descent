VERSION="0.1.0"
REPO=$(shell pwd)

default:
	@echo "No target specified"

.PHONY: build
build:
	@mkdir -p build/mods 2>/dev/null
	cd "$(REPO)/src/dimthing" && INSTALL_DIR="$(REPO)/build/mods" make install
	cd "$(REPO)/src/adresources" && INSTALL_DIR="$(REPO)/build/mods" make install

.PHONY: build-ports
build-ports:
	@mkdir -p build/mods 2>/dev/null
	cd "$(REPO)/src/ports/dimthing" && INSTALL_DIR="$(REPO)/build/mods" make install
	cd "$(REPO)/src/ports/adresources" && INSTALL_DIR="$(REPO)/build/mods" make install

.PHONY: install
install:
	@mkdir -p build/mods 2>/dev/null
	awk 'BEGIN {FS = ","} !/^#/ && NF { \
		gsub(/[\n\r]/, "", $$3); \
		cmd = "curl -sSLo \"build/mods/"$$1".jar\" \"https://www.curseforge.com/api/v1/mods/"$$2"/files/"$$3"/download""\""; \
		print cmd; system(cmd) }' mods.csv

.PHONY: copy
copy:
	@mkdir -p build 2>/dev/null
	cp -r overrides/* build/

.PHONY: all
all: build install copy
	echo "dev-$(VERSION)" $$(git rev-parse --short HEAD) > build/release.txt

.PHONY: export
export:
	rm -r "$(EXPORT_DIR) && mkdir -p "$(EXPORT_DIR)" && cp -r build/* "$(EXPORT_DIR)/"

.PHONY: clean
clean:
	rm -r build

.PHONY: fetch
fetch: 
	git fetch && git reset --hard origin/master

.PHONY: rebuild
rebuild: fetch clean all
