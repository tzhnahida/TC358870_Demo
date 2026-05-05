# TC358870XBG HDMI-to-MIPI DSI Bridge — Evaluation Board

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![PCB Status](https://img.shields.io/badge/PCB_Rev_1.0-Deprecated-red.svg)](design-notes.md)

> **Project code:** `tb` &nbsp;|&nbsp; **PCB name:** `tc358870_demo` &nbsp;|&nbsp; **Current PCB:** Rev 1.0 **(deprecated — do not fabricate)**
>
> See **[design-notes.md](design-notes.md)** for version history, errata details, lessons learned, and the Rev 2.0 plan.

A 4-layer PCB reference design for the **Toshiba TC358870XBG** bridge chip, which converts an **HDMI 1.4b** input stream (up to 4K×2K @30 fps, 7.2 Gbps) to a **dual-link MIPI DSI** output (up to 1 Gbps per data lane). The board is controlled by an on-board MCU via I2C and is supported by full signal-integrity simulation data.

---

## Hardware Overview

### Key Components

| Component | Part Number | Function |
|-----------|-------------|----------|
| Bridge IC | Toshiba TC358870XBG (BGA80) | HDMI 1.4b RX → MIPI DSI dual-link TX |
| Controller | STM32 (ST) | I2C master for register configuration, EDID management, HPD control |
| Power DCDC | — | Core supply (1.15 V) and MIPI D-PHY (1.2 V) |
| Power LDO | — | I/O (1.8 V / 3.3 V), HDMI (3.3 V), APLL (3.3 V) |

### Block Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      TC358870XBG (BGA80)                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────────┐  │
│  │ HDMI-RX  │  │ HDCP 1.4 │  │  Video   │  │   DSI TX0      │──┤── CDSI0 D[0:3]P/N + CLKP/N
│  │ TMDS     │→ │ Decrypt  │→ │  FIFO    │→ │   DSI TX1      │──┤── CDSI1 D[0:3]P/N + CLKP/N
│  │ 297 MHz  │  │ + eFuse  │  │ + CSC    │  └────────────────┘  │
│  └──────────┘  └──────────┘  └──────────┘                      │
│                                            ┌────────────────┐  │
│                   I2C Slave ────────────── │  RegFile &     │  │
│                   (Addr: 0x0F / 0x1F)      │  EDID SRAM     │  │
│                                            │  (1 KB)        │  │
│                                            └────────────────┘  │
└─────────────────────────────────────────────────────────────────┘

              ▲                            ▲
              │ I2C                        │ HDMI
         ┌────┴─────┐                ┌─────┴──────┐
         │   STM32   │               │ HDMI Source │
         │ (I2C Mst) │               │  (GPU/SOC)  │
         └──────────┘               └─────────────┘
```

### PCB Stack-Up (4 Layers)

| Layer | Type | Notes |
|-------|------|-------|
| TOP | Signal | HDMI TMDS, MIPI DSI, I2C, REFCLK, Audio |
| L2 (GND) | Solid Plane | Continuous ground return for all high-speed signals |
| L3 (POWER) | Split Plane | 1.15 V / 1.2 V / 1.8 V / 3.3 V |
| BOTTOM | Signal | Decoupling, test points, auxiliary routing |

### High-Speed Interface Routing

| Interface | Speed | Length Matching | Impedance Target |
|-----------|-------|----------------|------------------|
| HDMI TMDS (3 data + 1 clock) | ≤ 297 MHz pixel clock | ±5 mil within each pair | 100 Ω differential |
| MIPI DSI0 (4 lanes + clock) | 1 Gbps per lane | ±5 mil within pair, ±20 mil between lanes | 100 Ω differential |
| MIPI DSI1 (4 lanes + clock) | 1 Gbps per lane | ±5 mil within pair, ±20 mil between lanes | 100 Ω differential |
| REFCLK | 40–50 MHz | — | 50 Ω single-ended |

**SI counter-measures applied:**
- Continuous GND plane on L2 beneath all high-speed traces
- AC-coupling capacitors placed close to HDMI RX pins (0.1 µF per TMDS line)
- MIPI DSI series termination resistors (0–10 Ω) placed near the bridge outputs
- Via stitch fence along the HDMI/MIPI partition boundaries
- All differential pairs routed with 5 mil trace width / 7 mil spacing (on outer layers)

### PCB Design Errata

#### Errata (Rev 1.0)

| Signal | Issue | Correct | Hardware Fix |
|--------|-------|---------|--------------|
| MIPI DSI lanes | Lane/clock pair order swapped per datasheet | Swap per pin mapping | Re-route or bodge-wire — this rev damaged the LCD panel |
| HPDO (B4) | Shorted to VCC_HDMIRX_IN (+5V) | → 1 KΩ → HDMI pin 19 (HPD) | Cut trace to +5V, add 1 KΩ to HPD |
| HPDI (A4) | → R25 (100 KΩ) → HDMI pin 19 (HPD) | → 100 KΩ → HDMI pin 18 (+5V) | Move R25 from HPD to +5V rail |

> **Note:** The DSI lane/clock ordering mistake in Rev 1.0 caused the connected LCD panel to burn in
> (permanent pixel damage) because the panel ASIC received lane data on the wrong physical pairs.

#### Updates (Next Rev)

> See **[design-notes.md](design-notes.md)** for the full Rev 2.0 change list and planning notes.

| Interface | Current | Plan |
|-----------|---------|------|
| DDC bus | Direct to TC358870 only | Add EEPROM + external I2C connector |
| MIPI DSI lanes | Swapped (errata) | Re-route per datasheet pin mapping |

## Power Delivery

| Rail | Voltage | Source | Max Current (Est.) | Ripple Requirement |
|------|---------|--------|-------------------|-------------------|
| VDDC_CORE | 1.15 V | DCDC | 500 mA | < 30 mVpp |
| VDD12_MIPI0/1 | 1.2 V | DCDC | 200 mA (each) | < 20 mVpp |
| VDDIO18 | 1.8 V | LDO | 150 mA | < 30 mVpp |
| VDDIO33 / VDD33_HDMI | 3.3 V | LDO | 300 mA | < 30 mVpp |
| VDD33_APLL | 3.3 V | LDO (filtered) | 50 mA | < 10 mVpp |

---

## Firmware

The on-board STM32 controller is responsible for:

- **I2C register configuration** of the TC358870XBG (all internal registers, clock generation, DSI PHY tuning)
- **EDID management** using the bridge's internal 1 KB EDID SRAM (no external EEPROM required)
- **HPD (Hot-Plug Detect) sequencing** — the chip can assert HPD in manual mode or interlock with DDC 5V detection
- **DSI PLL programming** — generates up to 1 Gbps per data lane from a 40–50 MHz REFCLK
- **Interrupt handling** — video timing change, HDCP events, InfoFrame updates

The MCU project is configured via **STM32CubeMX** (`.ioc`) and compiled with **Keil MDK-ARM**.

Essential I2C register map (refer to `TC358870XBG_rev1.3.pdf` sections 5.2–5.11 for full details):

| Address | Register | Function |
|---------|----------|----------|
| `0x0000` | ChipID | Read-only chip identification (`0x47`) |
| `0x0002` | SysCtl | System control, **SLEEP** (bit 0) |
| `0x0004` | ConfCtl0 | Video/Audio path enable |
| `0x0108` | DSITX0_CLKEN | DSI0 clock enable |
| `0x0118` | DSITX0_LANE_EN | DSI0 lane enable (4 lanes) |
| `0x011C` | DSITX0_START | DSI0 stream start trigger |
| `0x02A0` | MIPI_PLL_CTRL | DSI0 PLL and clock control |
| `0x02AC` | MIPI_PLL_CONF | DSI0 PLL divider configuration |
| `0x0400` | EDID_SRAM_BASE | Internal EDID SRAM (1 KB) |
| `0x8410` | PHY_CTL | HDMI PHY control (auto/manual) |
| `0x8413` | PHY_ENB | HDMI PHY enable |
| `0x8414` | PHY_RSTX | HDMI PHY reset |
| `0x8520` | SYS_STATUS | 5V detect, HPD source status |
| `0x8544` | HPD_CTL | HPD output control (bit 4: mode, bit 0: output) |
| `0x854A` | INIT_END | Initialization complete flag |
| `0x85E0` | EDID_MODE | EDID source select (0 = external, 1 = internal SRAM) |
| `0x85E3` | EDID_LEN1 | EDID length low byte |
| `0x85E4` | EDID_LEN2 | EDID length high byte |

---

## Design Files

| File | Tool | Description |
|------|------|-------------|
| `TC358870_DEMO.DSN` | OrCAD Capture 17.4 | Full schematic |
| `TC358870_Demo.opj` | OrCAD Capture 17.4 | Project file |
| `deprecated/tc358870_demo.brd` | Cadence Allegro PCB Editor 17.4 | PCB layout (4-layer) — **Rev 1.0, deprecated** |
| `deprecated/bf.brd` | Cadence Allegro PCB Editor | Backup / variant layout — **deprecated** |
| `deprecated/gerber.zip` | — | Fabrication gerber set — **deprecated** |
| `deprecated/gerber/` | — | Individual Gerber RS-274X files — **deprecated** |
| `TC358870_DEMO.bom.xlsx` | — | Bill of materials |
| `deprecated/dcdc.mdd` | Allegro PCB Designer | DCDC module master drawing — **deprecated** |
| `deprecated/ldo.mdd` | Allegro PCB Designer | LDO module master drawing — **deprecated** |
| `deprecated/ida.run/` | Cadence PowerSI | Signal integrity and power-integrity simulation |
| `deprecated/signoise.run/` | Cadence SigNoise | Crosstalk analysis |
| `Test_code/TestCode.ioc` | STM32CubeMX | MCU pin/clock configuration |
| `Test_code/Core/` | Keil MDK-ARM v5 | Firmware source code (C) |
| `Test_code/TC358870XBG_rev1.3.pdf` | — | Official Toshiba datasheet |

### Fabrication Outputs (Gerber RS-274X)

Located in `deprecated/gerber/`:

| File | Content |
|------|---------|
| `1_TOP.art` | Top copper |
| `2_GND.art` | Ground plane (L2) |
| `3_POWER.art` | Power plane (L3) |
| `4_BOTTOM.art` | Bottom copper |
| `SILKSCREEN_TOP/BOTTOM.art` | Silkscreen legends |
| `SOLDMASK_TOP/BOTTOM.art` | Solder mask openings |
| `PASTEMASK_TOP/BOTTOM.art` | Paste mask for stencil |
| `ASM_TOP/BOTTOM.art` | Assembly drawings |
| `tc358870_demo-1-4.drl` | NC drill file |
| `DRILL.art` | Drill legend |

---

## Getting Started

### Prerequisites

- Cadence OrCAD Capture 17.4 (or later) — schematic viewing/editing
- Cadence Allegro PCB Editor 17.4 (or later) — PCB layout viewing/editing
- Cadence PowerSI (optional) — SI/PI simulation
- Keil MDK-ARM v5 — firmware compilation and debug
- STM32CubeMX — MCU peripheral configuration

### Firmware Build

1. Open `Test_code/MDK-ARM/TestCode.uvprojx` in Keil MDK-ARM.
2. Build and download to the target STM32.
3. The MCU enumerates the bridge via I2C, writes the EDID into the internal SRAM, and asserts HPD.

### PCB Fabrication

> **Warning:** Rev 1.0 is deprecated. See **[design-notes.md](design-notes.md)** before fabricating.

1. Extract `deprecated/gerber/` and send all `.art` files plus the `.drl` drill file to your manufacturer.
2. Specify **4-layer**, **1.6 mm** nominal thickness, **FR-4** (or equivalent), **ENIG** finish.
3. Impedance control: **100 Ω differential** on outer layers for HDMI and MIPI DSI pairs.

---

## Signal Integrity

The `deprecated/ida.run/` directory contains **Cadence PowerSI** simulation results:

- **S-parameter extraction** for the HDMI TMDS and MIPI DSI channels (DC to 5 GHz)
- **Crosstalk analysis** between DSI0 and DSI1 lane bundles (`xtlk/`)
- **Time-domain reflectometry (TDR)** impedance profiles
- **IR drop analysis** for the power delivery network

Refer to `deprecated/ida.run/rtp/` for fitted touchstone (`.s20p`) models and SPICE netlists of the critical interconnects.

---

## License

This project is licensed under the **Apache License, Version 2.0**. See [LICENSE](LICENSE) for details.

---

## References

- [TC358870XBG Datasheet (rev 1.3)](Test_code/TC358870XBG_rev1.3.pdf) — Toshiba
- *HDMI Specification 1.4a* — HDMI Licensing, LLC
- *MIPI DSI Specification v1.1* — MIPI Alliance
- *MIPI D-PHY Specification v1.00* — MIPI Alliance
