# Errata

# v1.3.0

- switched to an 18650 based 12v power supply for the portable variant:
  - simple flow: usb-c in front, 12v out back
  - so no need for usb pd trigger or patch cable
  - also only needs a classic 5v usb source, so no need for higher volt/watt adaptors
  - when loaded with 2x 9900mAh 3.7v cells, we get 4-5hrs of runtime from a full charge
- minimized base plate height and clip socket placement
  - since the new battery housing is taller than prior bank, this keeps the base plate from bulking up too much
  - also this makes clip insertion and socket flex more consistent, as both rows now have a thing floor or roof

# v1.2.1

- added a grommet for the cover plate wire ports to prevent
  wires getting pinched between plates when (re)assembling
- added a tiny (0.5mm) chamfer to bottom edge of base plate,
  minor print quality improvement, and feels smoother
- minor internal code cleanups towards different battery module
- moved the pwm controller grill mount point 5mm inward,
  improving its fan header clearance to cover plate port,
  especially when using the new grommet part

# v1.2.0

- Mesh walls now serve as primary vertical integration,
  holding the base and cover plates together rigidly,
  in addition to the filter snap fit itself.
  This was done by adding a triangular foot to the top/bottom of mesh wall sections,
  with corresponding shape in each plate slot channel.
- Moved the cover notch to the inner side of the filter diameter, added a corresponding notch to the base plate.
  With the mesh wall foot, notch is no longer useful to remove/install wall sections externally,
  and otherwise only presented a snag hazard to sliding wall sections.
  Now the new notch placements only help with filter installation from the interior only.
- **NOTE**: because of these changes, and many minor improvements to plate diameter maths along the way, v1.2 plates will not be compatible with v1.1 parts.
- total cost is down marginally ( -2 hours print time and -$3 bom cost )

# v1.1.3

- reworked duo 3mf project
  - all base variants and wall variants in one project, no portable-vs-stationary difference
  - spread out joiner clip placement so that there are some on each base plate to catch some flush
  - include all 4 wall section variants
- moved base labels to their bottom surface (against the build plate);
  this allows them so be seen without disassembling,
  plus should have overall higher surface quality artifacts.
- added varying wall section modes for: no dovetail, only female dovetails, only male dovetails, and both dovetail edges;
  this allows assembling a "hemi-loop" for the mesh wall, which can provide stronger join around the bend, at the tradeoff of being harder to assemble
- renamed test label part model files
- minor improvements to release script and base label preview mode

# v1.1.2

- switched [sqadqr](https://github.com/xypwn/scadqr) for native qr generation
- pulled out label text/qr particulars into customizer parameters
- internal git repository cleanups:
  - fixed bosl2 submodule url
  - evicted all model and image assets into git-lfs blob storage
  - minor fix to release script

# v1.1.1

- remade wall section and slot shapes based on X-oriented extrusion of a profile
  - the wall profile remains a simple square, while the slot is still a drafted trapezoid...
  - ...for now, but this makes it easy to evolve their shapes to include a triangular foot to provide vertical holding strength
  - broke up the wall vs slot test models, as this makes printing them easier
- parameterize cover notch placement, since it's about to move position in next minor revision
- clarified internal cover/base common diameter
  - there's a lot slightly off with slot/wall diameter maths/metrics that v1.2 will fix, but doing so will break plate size/fit slightly

# v1.1.0

- added power bank cavity and access tunnel inside of a thicker base plate variant
- moved power port location as far left as possible; corner of power channel now comes close to base filter retention ring
- added optional grill box ears with anchor holes for a shoulder strap
- added cutout notch to cover underside, allowing easier removal of mesh wall and filter
- added positive base label models for easy multi color prints;
  this also makes the up-surface of the base plates smooth (when doing a multi-color print)
- changed PWM controller module to a more minimal pcb mounted thru the front of left fan grill box; removed grill window
- improved mesh wall stability:
  - now thicker so that it's both stronger, and so that sections cannot overlap each other as easily when slotted
  - tapered the dovetails alternating directions so that they hold together like a hinge
  - but not using dovetail by default/recommendation due to how difficult they are to assemble and manage
  - also added a wall bender arch to help form smooth wall bends with a heat gun
- improved strength of base and cover plate filter grips
  - release candidate testing, noticed a minor layer separation break near A side cover notch
  - increased thickness of the wall between the filter recess cavity and the mesh wall channel
  - further trimmed base plate geometry to reduce extra added interstitial space a little
  - **NOTE**: this change will slightly invalidate fit with prior base and cover plates,
    but the overall quality / strength makes it a worthy reprint

# v1.0.5

- revamped assembly preview, including parts explosion and animation
- remade wallslot geometry to be a direct path extrusion,
  should reduce any boundary artifacts similar to the plate remake in v1.0.2
- many minor code improvements on the way to v1.1
- dropped part kit model, slicing user can just add parts as needed

# v1.0.4

- revamped base label text to fit just inside the filter inner diameter;
  this is not just aesthetic, as cut text underneath the filter's rubber seal could potentially cause unintended air ingress
- increased joiner clip compression now that we've got better socket tolerance and print quality
- made the preview assembly easy to recolor
- several minor code level improvements while working towards v1.1

# v1.0.3

- added project and filter notes inside base plate
- added a user guide stub document with link embedded in QR code within base plate
- renamed most duo model files to follow an A (left) and B (right) side convention
- renamed the power channel plug model file
- many internal code cleanups and improvements while working on upcoming new features

# v1.0.2

- improved duo plate geometry, especially where half-circle transitions to a straight line;
  this should reduce facet-seam artifacts in the printed parts
- improved power socket internal fit, by chamfering the interior corner of the lip;
  this should make socket installation easier, preventing the usb-c socket from
  getting stuck on the lip when sliding forward into position
- added designed support inside clip socket; addressed slight roof droop/stringing, which was affecting clip tolerance

# v1.0.1

- switched to an even number of wrap wall sections, to avoid placing a join seam at the point of most strain
- made the power channel plug fit tighter, and also made its removal notch larger to ease removal with pliers
- improved base plate power socket geometry where it comes near to the mesh wall slot
- added a clip/socket fit test, and used it to make it tune socket size, allowing much easier assembly
- dropped unused fan wire channel option from the cover plate
- added textual guide and parts list based on prototype build
- expanded project level documentation including design notes, slicer setting recommendations, etc
- cleaned up and documented customizable parameters

# v1.0.0

- first dual filter prototype version completed

# Dev Status and TODOs

- [ ] TODO deprecate, minimize, or just drop power bank support
- [ ] TODO further explore 18650 integration, something like:
  - minimal BMS board
  - pd trigger module for input
  - battery cells integrated directly into base plate cavities
- [ ] TODO support scaling down to single-stack assembly
  - [ ] TODO car mount option: baseplate with a cupholder mount
- [ ] TODO support N-filter stacks with a joiner plate
- [ ] TODO support N-fan stacks, but also take care, and support inter-fan spacing
- [ ] TODO support N-assembly: straight plate mode to allow horizontal scale
- [ ] TODO inter-filter structure for duo to support additional electronics inside the mesh wall
- [ ] TODO evolve parameters, with presets for various fan/filter models
- [ ] TODO support arduino based electronics package, including an [air quality sensor wing][aq_wing]

[aq_wing]: https://hackaday.io/project/168492-the-air-quality-wing

[rc]: https://github.com/jcorbin/pchepa/tree/rc
[testing]: https://github.com/jcorbin/pchepa/tree/testing
[dev]: https://github.com/jcorbin/pchepa/tree/dev
