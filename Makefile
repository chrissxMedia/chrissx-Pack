FILES = pack.mcmeta pack.png $(shell find assets -type f)
AUTHOR = pixel, chrissx Media
VERSION = 5
HOMEPAGE = https://github.com/chrissxMedia/chrissx-Pack
FULLNAME = chrissx-Pack-$(VERSION)
OUTFILE = $(FULLNAME).zip

all: $(OUTFILE)

$(OUTFILE): $(FILES)
	zip -9 $@ $^

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

.PHONY: all version outfile clean
