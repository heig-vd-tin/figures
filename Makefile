# We convert all the vector source images into svg
# .vsdx -> .contrib.svg
# .pdf  -> .svg
DISTDIR=_dist

VSDXs=$(shell find * -type f -name '*.vsdx')
SVGS=$(patsubst %.vsdx,$(DISTDIR)/%.svg,$(VSDXs))

all: $(SVGS)

$(DISTDIR)/%.svg: %.vsdx | $(DISTDIR)
	mkdir -p $(dir $@)
	./visio2svg.sh $< $@

$(DISTDIR):
	mkdir $@

COMMIT!=git rev-parse HEAD

publish:
	git checkout dist
	mv _dist/* .
	rmdir _dist
	find * -iname '*.svg' | xargs git add
	git commit -m "Sync dist branch with " $(COMMIT)
	git checkout master

.PHONY: all publish