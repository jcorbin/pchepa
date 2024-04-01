DUAL_FILTER_MODELS=pchepa_base.stl pchepa_base_with_usbc_port.stl pchepa_cover.stl pchepa_grill.stl pchepa_clip.stl pchepa_base_channel_plug.stl pchepa_test.stl

all: $(DUAL_FILTER_MODELS)

clean:
	rm -f $(DUAL_FILTER_MODELS)

pchepa_base.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=1 -D base_with_usbc_port=false

pchepa_base_with_usbc_port.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=1 -D base_with_usbc_port=true

pchepa_cover.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=2

pchepa_grill.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=3

pchepa_clip.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=10

pchepa_base_channel_plug.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=11

pchepa_wall_section.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=12

pchepa_test.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=42

pchepa_power_module_test.stl: pchepa.scad pchepa.mk
	openscad $< -o $@ -D filter_count=2 -D mode=43
