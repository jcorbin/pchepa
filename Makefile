SCAD=pchepa.scad

MODELS=$(shell grep '//@make ' $(SCAD) | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')

all: $(MODELS)

clean:
	rm -f $(MODELS)

$(SCAD): init user_guide/v1.qr.png

BOSL2/std.scad:
	git submodule update --init

$(MODELS): $(SCAD)
	test -d $(dir $@) || mkdir -p $(dir $@)
	openscad $< $(shell grep '//@make ' $< | grep -- ' -o $@' | sed -r -e 's/^\/\/@make //')

regen:
	git diff --exit-code pchepa.scad
	rm -f pchepa.scad && git checkout -f pchepa.scad
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) duo/as_explode.gif
	git add $(MODELS)
	git commit -m 'Regenerate models'

duo/as_explode.gif:
	convert $$(ls -1 duo/as_explode*.png; ls -1 duo/as_explode*.png | tac) -set delay 4 duo/as_explode.gif

GOBIN ?= $(shell go env GOPATH)/bin
QRCODE=$(GOBIN)/qrcode

$(QRCODE):
	go install github.com/skip2/go-qrcode/qrcode@latest

%.qr.png: %.link $(QRCODE)
	$(QRCODE) -d '$(shell head -n1 $<)' >$@

init: BOSL2/std.scad
	git config filter.git_scad_vars.smudge >/dev/null || git config --local include.path ../.gitconfig
