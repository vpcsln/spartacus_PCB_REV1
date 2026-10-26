# SPARTACUS-HF REV1 PCB

KiCad source of the first assembled board of
[SPARTACUS-HF](https://spartacus-hf.dev), an HF transceiver for amateur and
emergency radio. SPARTACUS-HF is an independent project developed by
Electrical Engineering and Information Technology students at RWTH Aachen
University.

REV1 is assembled in a 3D-printed enclosure. On 2 October 2026 it made its
first two-way FT8 contacts on 40 m (7.074 MHz), handling both receive and
transmit. Calibrated RF, spectral, thermal and protection measurements are
still open.

## The board

| | |
|---|---|
| Size | 175 × 100 mm |
| Layers | 6 layers, 1.6 mm, 35 µm copper; In1 and In4 are ground planes next to the outer layers |
| Parts | 438 footprints, mixed SMD and through-hole, hand-wound RF magnetics |
| Controller | STM32G474; its HRTIM generates the transmit and receive clocks |
| Transmitter | Two Class-D switching branches (BS170) with digital outphasing and envelope control, combined by transformers |
| Receiver | Tayloe quadrature sampling detector with a PCM1821 stereo audio ADC |
| Filters | Five switched low-pass sections with forward/reverse power sensing; receive band-pass filters |
| Interfaces | USB-C power delivery and separate USB-C data, fused barrel input, BNC RF output, three 3.5 mm audio and key ports, SD card, LCD, encoder and buttons |

- [REV1 build and first contacts](https://spartacus-hf.dev/en/rev1-first-contacts/)
- [Interactive board viewer](https://spartacus-hf.dev/en/technology/)
- [S-CTRL](https://github.com/vpcsln/spartacusControl), the Linux desktop and command-line companion

## Open the design

1. Install **KiCad 10.0.5**, including its standard symbol, footprint, and 3D
   model libraries.
2. Clone this repository.
3. Open `v1sch.kicad_pro`.

The custom symbols, footprints, legacy Eagle libraries, and custom 3D models
used by the design are committed below `libraries/`. Both KiCad library tables
use `${KIPRJMOD}` paths, so a clone can live in any directory on Linux, macOS,
or Windows.

## Verify a clone

With KiCad 10.0.5 installed:

```sh
./scripts/verify-project.sh
```

Or use the immutable official KiCad 10.0.4 CLI container:

```sh
make verify-container
```

Reports are written to `build/reports/`. Existing ERC or DRC findings are
reported for engineering review; the verification fails only if the pinned
toolchain is wrong, a required file is missing, a non-portable path is found,
or KiCad cannot load and check the design.

See [REPRODUCIBILITY.md](REPRODUCIBILITY.md) for the reproducibility boundary
and [CONTRIBUTING.md](CONTRIBUTING.md) for the update workflow.

## Licence

The SPARTACUS-HF design files in this repository are licensed under the
[CERN Open Hardware Licence Version 2 - Strongly Reciprocal](LICENSE)
(CERN-OHL-S-2.0). See [NOTICE](NOTICE). The library snapshots under
`libraries/` come from third parties and keep their upstream terms (see
[libraries/README.md](libraries/README.md)).

This is a development design. It has not completed manufacturing, safety,
regulatory, transmitter or receiver qualification.
