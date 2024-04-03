SCAD=pchepa.scad

MODELS=$(shell grep -E -o '//@make +[^ ]+' $(SCAD) | sed -e 's/^[^ ]* *//')

all: $(MODELS)

clean:
	rm -f $(MODELS)

$(MODELS): $(SCAD)
	test -d $(dir $@) || mkdir -p $(dir $@)
	openscad $< -o $@ $(shell grep '//@make $@' $< | sed -r -e 's/^\/\/@make +[^ ]+//' -e 's/ / -D /g')
