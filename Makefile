DUAL_FILTER_MODELS=pchepa_duo/base.stl pchepa_duo/base_with_usbc_port.stl pchepa_duo/cover.stl pchepa_duo/grill.stl pchepa_duo/clip.stl pchepa_duo/base_channel_plug.stl pchepa_duo/test.stl

all: $(DUAL_FILTER_MODELS)

clean:
	rm -f $(DUAL_FILTER_MODELS)

pchepa_duo/base.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=1 -D base_with_usbc_port=false

pchepa_duo/base_with_usbc_port.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=1 -D base_with_usbc_port=true

pchepa_duo/cover.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=2

pchepa_duo/grill.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=3

pchepa_duo/clip.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=10

pchepa_duo/base_channel_plug.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=11

pchepa_duo/wall_section.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=12

pchepa_duo/parts.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=20

pchepa_duo/test.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=42

pchepa_duo/power_module_test.stl: pchepa.scad pchepa.mk
	test -d pchepa_duo || mkdir mkdir pchepa_duo
	openscad $< -o $@ -D filter_count=2 -D mode=43
