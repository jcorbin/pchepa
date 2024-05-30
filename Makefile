SCAD=pchepa.scad

MODELS=$(shell grep '//@make ' $(SCAD) | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')
STATIC_MODELS=$(shell grep '//@make ' $(SCAD) | grep -v -- --animate | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')
ANIM_MODELS=$(shell grep '//@make ' $(SCAD) | grep -- --animate | grep -E -o -- ' -o +[^ ]+' | sed -e 's/^ -o //')
ANIMATED_MODELS=$(patsubst %.png,%.gif,$(ANIM_MODELS))

all: $(MODELS) $(ANIMATED_MODELS)

clean:
	rm -f $(MODELS)

$(SCAD): init

BOSL2/std.scad:
	git submodule update --init

$(MODELS): $(SCAD)
	test -d $(dir $@) || mkdir -p $(dir $@)
	openscad $< $(shell grep '//@make ' $< | grep -- ' -o $@' | sed -r -e 's/^\/\/@make //')

.PHONY: $(ANIMATED_MODELS)

$(ANIMATED_MODELS): $(patsubst %.gif,%.png,$@)
	convert $$(ls -1 $(patsubst %.gif,%*.png,$@) ; ls -1 $(patsubst %.gif,%*.png,$@) | tac) -set delay 4 $@

regen:
	$(MAKE) clean
	$(MAKE) rebuild
	git add $(STATIC_MODELS) $(ANIMATED_MODELS)
	git commit -m 'Regenerate models'

rebuild:
	git diff --exit-code pchepa.scad
	rm -f pchepa.scad && git checkout -f pchepa.scad
	$(MAKE) $(MODELS)
	$(MAKE) $(ANIMATED_MODELS)

init: BOSL2/std.scad
	git config filter.git_scad_vars.smudge >/dev/null || git config --local include.path ../.gitconfig
