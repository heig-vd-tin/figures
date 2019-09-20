# We convert all the vector source images into svg
# .vsdx -> .contrib.svg
# .pdf  -> .svg
DISTDIR=dist

VSDXs=$(shell find src/* -type f -name '*.vsdx')
SVGS=$(patsubst src/%.vsdx,$(DISTDIR)/%.svg,$(VSDXs))

all: $(SVGS)

$(DISTDIR)/%.svg: %.vsdx | $(DISTDIR)
	mkdir -p $(dir $@)
	./visio2svg.sh $< $@

$(DISTDIR):
	mkdir $@

COMMIT!=git rev-parse HEAD

publish:
	git checkout dist
	mv $(DISTDIR)/* .
	rmdir $(DISTDIR)
	find * -iname '*.svg' | xargs git add
	git commit -m "Sync dist branch with " $(COMMIT)
	git checkout master

.PHONY: all publish
