REPO=$(shell pwd)

.PHONY: build
build:
	mkdir mods &2>/dev/null
	cd "$(REPO)/src/dimthing" && make clean && mv *.jar "$(REPO)/mods/"
	cd "$(REPO)/src/breakthings" && make clean && mv *.jar "$(REPO)/mods/"

.PHONY: install
install:
	mkdir mods &2>/dev/null
	awk 'BEGIN {FS = ","} {gsub(/[\n\r]/, "", $$3); cmd = "curl -sSLo \"mods/"$$1".jar\" \"https://www.curseforge.com/api/v1/mods/"$$2"/files/"$$3"/download""\""; print cmd; system(cmd)}' mods.csv

.PHONY: copy
copy:
	mkdir mods &2>/dev/null
	cp "mods_overrides/*" "mods/"

.PHONY: all
all: build install copy
