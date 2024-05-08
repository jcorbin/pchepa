SCAD=pchepa.scad

MODELS=$(shell grep '//@make ' $(SCAD) | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')

all: $(MODELS)

clean:
	rm -f $(MODELS)

$(SCAD): BOSL2/std.scad

BOSL2/std.scad:
	git submodule update --init

$(MODELS): $(SCAD)
	test -d $(dir $@) || mkdir -p $(dir $@)
	openscad $< $(shell grep '//@make ' $< | grep -- ' -o $@' | sed -r -e 's/^\/\/@make //')

regen:
	$(MAKE) clean
	$(MAKE) all
	git add $(MODELS)
	git commit -m 'Regenerate models'

GOBIN ?= $(shell go env GOPATH)/bin
QRCODE=$(GOBIN)/qrcode

$(QRCODE):
	go install github.com/skip2/go-qrcode/qrcode@latest

%.qr.png: %.link $(QRCODE)
	$(QRCODE) -d '$(shell head -n1 $<)' >$@
