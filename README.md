# 100_fingers project: Parametric hand
![Human, mirrored human, and aye-aye hand designs and assemblies](/media/hands.png)

Figure 1: Three example hands included in the initial release and presented in [(1)](#list-of-publications).

Generating large numbers of anatomical parameterised fingers and hands with OpenSCAD (https://openscad.org/).

## Intro
Code for generating the initial hand version and 3D files for reproduction and modular actuation.
The hand is designed for single-piece 3d printing with consumer-grade printers, enabling rapid customisation and large-scale real-world experimentation.
Additionally, the hand is designed to be uncomprimising with actuation. Five tendons per four degree of freedom finger allows full control. Though for simplicity, accessibility, and exploration of hand behaviours, the included actuation system examples rely heavily on underactuation by connecting the majority of tendons to passive springs.

### Summary of files
- /OpenSCAD: scripts for generating hands with OpenSCAD. parameters.scad for demo use and parameters for generating example hands
- /STLs: 3D files for 3D printable parts
  - /STLs/hands: three example hands generated from parameters.scad and example generated for visualisation (no_lig)
  - /STLs/actuation_box: 3D files for three examples of modular actuation (1 degree-of-freedom(dof)/synergy, 2 dof/synergy, 1 dof with switching modulation)
  - /STLs/manual_handles: 3D files for manual lever actuation and handles for 1 and 2 dof actuation boxes
- /build_guide: PDF, timelapse, and annotated video of build process for release v1.2
- /media: images from publication (in progress)

### Hand customisation
![Screenshot of parameters.scad in OpenSCAD](/media/parameters.png)

Figure 2: Hand parameters.

In the current version, all bone lengths, widths, and joint diameters can be altered, as can: relative finger position, pulley size/strength, ligament size/strength, and hand inward curvature. Possible to customise but requires code modification include: number of fingers/thumbs, individual pulley/ligament size and more.

## Fabrication instructions
### Hand assembly
![Steps for 3D printing and attaching tendons](/media/printing.png)
Figure 3: Hand printing and assembly.

See [/build_guide](https://github.com/kg398/100_fingers/tree/main/build_guide) for more detailed fabrication tips and assembly information, and [bill of materials](#bill-of-materials) for basic acquisition requirements.

Hands can be printed via commercial FDM printers (Prusa/Creality/Craftbot/Raise3D tested). General printing requirements are: large build volume and semi-flexible materials. **Polypropylene** printing is recommended for good living hinge properties and relative ease of printing with a single extruder and standard temperatures. Print orientation is critical (palm should face down with fingertips closest to build plate and all ligament pairs flat relative to the build plate).

SLS printing is also suitable. Only polyamide (PA2200) has been tested, resulting in stiffer bones than polypropylene and a cleaner print. Orientation is less critical.

![Actuation box features and tendon routing paths](/media/actuation.png)

Figure 4: Tendon routing and actuation.

Once the hand is printed, tendons must be routed manually. Depending on application, braided nylon from 0.2--0.5mm diameter is suitable (0.2mm is easier to work with and results in less friction, though has lower load potential). Tie with self-tightening knots to countersunk M2 bolts following routing from Figure 4.

Actuation box is assembled as in Figure 4 with M2 and M3 bolts. All springs (passive tendon and active series elastic) should be approx 10--15mm free length and 0.06--1N/mm spring constant.

![Human hand design with double pulley actuation gif](/media/double_pulley_manual_handle.gif)

Figure 5: Whole assembly and manual actuation.

Manual handles allow testing of Bowden tube actuation and exploration of hand behaviours.

## In progress

Look out for future updates on:
- Hand design database and modelling/behaviour guide
- Parametric skin for printing/casting

## Appendix
### Demos
![Resting state to ready joint state by tensioning all tendons gif](/media/hand_tension.gif)

Figure 6: Joint organisation through tension.

![Throwing and catching a lemon with the mirrored hand design gif](/media/2thumb_catching.gif)

Figure 7: Mirrored hand catching demo.

![Manual picking up and using a computer mouse with the aye-aye hand design](/media/aya_aye_demo.gif)

Figure 8: Aye-aye hand demo.

### Bill of materials
Bill of materials for FDM printed human hand design with 1 dof actuation.

| Part  | Description | Quantity |
| ------------- | ------------- | ----: |
| Polypropylene filament  | Single-piece printed hand  | 80 (g) |
| M2x4 countersunk bolts | Tendon anchors | 21 |
| Braided fishing line, ~0.2 mm diameter, >20 kg load | Tendons | 10 (m) |
| ------------- | ------------- | ---- |
| PLA filament  | Actuation box printed parts  | 50 (g) |
| Extension springs (l: 10--15 mm; k: 0.1--1 N/mm) | Passive tendon mounting and SEA | 26 |
| 15x5x4 mm flanged bearing (flangeD/ID/W) | Actuation pulley mounting | 2 |
| 50x4mm smooth rod | Passive tendon bearing surface, e.g. aluminium | 3 |
| 60x1.5mm smooth rod | Passive tendon pins, e.g. fibreglass | 3 |
| Braided fishing line, ~1 mm diameter, >80 kg load | Actuation tendon |	0.3 (m) |
| M2x4 countersunk bolts |	SEA spring mount |	5 |
| M2x4 caphead |	Box assembly, passive tendon anchors, t-select |	3+21+1 |
| M2x8 caphead |	Box assembly and active tendon anchors |	6+6 |
| M2x10 caphead |	Box assembly and SEA pins |	2+2 |
| M2 nut |	Passive and active tendon anchors |	21+5 |
| M3x6 caphead |	Box assembly, wrist and handle mounting |	6+4+4 |
| M4x12 grub screw |	Hand mount |	2 |
| M5x16 caphead |	Pulley shaft |	1 |
| ------------- | ------------- | ---- |
| PLA filament  | Manual handle printed parts  | 100 (g) |
| 140x4 threaded rod, steel |	Tendon anchor and lever backbone |	1 |
| M4x25 caphead |	Anchor locking pin |	1 |
| M4 nut, square |	Tendon anchor |	4 |
| M5x25 caphead |	Lever shaft |	1 |


### List of publications
- (1) Gilday, K., Sirithunge, C., Iida, F., \& Hughes, J. (2025). Embodied manipulation with past and future morphologies through an open parametric hand design. Science Robotics, 10(102), eads6437. [/10.1126/scirobotics.ads6437](https://doi.org/10.1126/scirobotics.ads6437) (arxiv: [/10.48550/arXiv.2410.18633](https://doi.org/10.48550/arXiv.2410.18633))
- (2) Carlet, R., Gilday, K., & Hughes, J. (2025, April). Behaviour Range Optimization of the Dexterous Robotic Open Parametric Hand. In 2025 IEEE 8th International Conference on Soft Robotics (RoboSoft) (pp. 1-7). IEEE. [/10.1109/RoboSoft63089.2025.11020976](https://doi.org/10.1109/RoboSoft63089.2025.11020976)
- (3) Gilday, K., Pyeon, D., Dhanush, S., Cho, K. J., & Hughes, J. (2024). Exploiting passive behaviours for diverse musical playing using the parametric hand. Frontiers in Robotics and AI, 11, 1463744. [/10.3389/frobt.2024.1463744](https://doi.org/10.3389/frobt.2024.1463744)
