AUTHOR = pixel, chrissx Media
VERSION = 5
HOMEPAGE = https://github.com/chrissxMedia/chrissx-Pack

FULLNAME = chrissx-Pack-$(VERSION)
OUTFILE = $(FULLNAME).zip

FILES = pack.mcmeta pack.png $(shell find assets -type f)

ifeq ($(OS),Windows_NT)
	MINECRAFT_DIR ?= $(APPDATA)/.minecraft
else ifeq ($(shell uname -s 2>/dev/null || echo Unknown),Darwin)
	MINECRAFT_DIR ?= $(HOME)/Library/Application Support/.minecraft
else
	MINECRAFT_DIR ?= $(HOME)/.minecraft
endif

all: $(OUTFILE)

$(OUTFILE): $(FILES)
	zip -9 $@ $^

deps: $(FILES)

pack.mcmeta: meta.raw.json Makefile
	sed 's/$$AUTHOR/$(AUTHOR)/;s/$$VERSION/$(VERSION)/;s/$$HOMEPAGE/$(shell echo '$(HOMEPAGE)' | sed 's/\//\\\//g')/' $< > $@

%.png: %.svg
	inkscape -o $@ $<

assets/minecraft/textures/gui/options_background.png: pack.png
	cp -f $< $@

version:
	@echo '$(VERSION)'

outfile:
	@echo '$(OUTFILE)'

fullname:
	@echo '$(FULLNAME)'

clean:
	rm -f pack.png pack.mcmeta

install:
	cp -f $(OUTFILE) $(MINECRAFT_DIR)/resourcepacks/

.PHONY: all deps version outfile fullname clean install
