SCAD=pchepa.scad

MODELS=$(shell grep '//@make ' $(SCAD) | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')
STATIC_MODELS=$(shell grep '//@make ' $(SCAD) | grep -v -- --animate | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')
ANIM_MODELS=$(shell grep '//@make ' $(SCAD) | grep -- --animate | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')

all: $(MODELS)

clean:
	rm -f $(MODELS)

$(SCAD): init user_guide/v1.qr.png

BOSL2/std.scad:
	git submodule update --init

$(MODELS): $(SCAD)
	test -d $(dir $@) || mkdir -p $(dir $@)
	openscad $< $(shell grep '//@make ' $< | grep -- ' -o $@' | sed -r -e 's/^\/\/@make //')

ANIMATED_MODELS=$(patsubst %.png,%.gif,$(ANIM_MODELS))

regen:
	git diff --exit-code pchepa.scad
	rm -f pchepa.scad && git checkout -f pchepa.scad
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) $(ANIMATED_MODELS)
	git add $(STATIC_MODELS) $(ANIMATED_MODELS)
	git commit -m 'Regenerate models'

.PHONY: $(ANIMATED_MODELS)

$(ANIMATED_MODELS):
	$(MAKE) $(patsubst %.gif,%.png,$@)
	convert $$(ls -1 $(patsubst %.gif,%*.png,$@) ; ls -1 $(patsubst %.gif,%*.png,$@) | tac) -set delay 4 $@

GOBIN ?= $(shell go env GOPATH)/bin
QRCODE=$(GOBIN)/qrcode

$(QRCODE):
	go install github.com/skip2/go-qrcode/qrcode@latest

%.qr.png: %.link $(QRCODE)
	$(QRCODE) -d '$(shell head -n1 $<)' >$@

init: BOSL2/std.scad
	git config filter.git_scad_vars.smudge >/dev/null || git config --local include.path ../.gitconfig
