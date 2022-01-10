FILES = pack.mcmeta pack.png $(shell find assets -type f)
AUTHOR = chrissx \& GammlaBrause
VERSION = 0.0.4
HOMEPAGE = https://github.com/chrissxMedia/chrissx-Pack
OUTFILE = chrissx-Pack-$(VERSION).zip

all: $(OUTFILE)

$(OUTFILE): $(FILES)
	zip -9 $@ $^

pack.mcmeta: meta.raw.json Makefile
	sed 's/$$AUTHOR/$(AUTHOR)/;s/$$VERSION/$(VERSION)/;s/$$HOMEPAGE/$(shell echo '$(HOMEPAGE)' | sed 's/\//\\\//g')/' $< > $@

version:
	echo '$(VERSION)'

outfile:
	echo '$(OUTFILE)'
