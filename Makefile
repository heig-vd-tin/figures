# We convert all the vector source images into svg
# .vsdx -> .contrib.svg
# .pdf  -> .svg
VSDXs=$(shell find . -type f -name '*.vsdx')
SVGC=$(patsubst %.vsdx,%.svg,$(VSDXs))

# Make generated files from python scripts (Temporarly RST)
contrib=$(RST) $(SVGC)

# Make a rule to build the PDFs
contrib: $(contrib)

%.svg:%.vsdx
	@printf "\e[36mvisio2svg\e[0m $< \e[2m--> $@\e[0m\n"
	chmod +x ./scripts/visio2svg.sh # Because Git sometime removes the x flag
	./scripts/visio2svg.sh $<
