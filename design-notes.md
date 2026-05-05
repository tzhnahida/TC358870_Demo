# Design Notes

## Project Information

| Field | Value |
|-------|-------|
| Project name | TC358870XBG HDMI-to-MIPI DSI Bridge — Evaluation Board |
| Project code | `tb` (TC358870 Bridge) |
| PCB name | `tc358870_demo` |
| PCB naming format | `<code>_<board>-rev<rev>-<YYMMDD>-<category>.brd` |

### Sub-Projects

| Code | Name | PCB |
|------|------|-----|
| `tb` | TC358870 DSI Bridge (main) | `tc358870_demo` |

## PCB File Naming Standard

All PCB design files follow this convention:

```
<code>_<board>-rev<rev>-<YYMMDD>-<category>.brd
```

**Rules:**
- **All lowercase letters** — no uppercase, no mixed case.
- **Project code** — short alphabetic abbreviation, not the full project name.
- **Revision** — `revA1`, `revA2`, …, `revB`, etc.
- **Date** — `YYMMDD` (e.g., `250915` = 2025-09-15).
- **Category** — module or function: `aio` (all-in-one), `dcdc`, `ldo`, `pmic`, `bridge`, etc.

**Examples:**

| File | Meaning |
|------|---------|
| `dt_bridge-revA2-250915-aio.brd` | DT project, bridge board, rev A2, 2025-09-15, all-in-one |
| `ht_pmic-revB-250906-dcdc.brd` | HT project, PMIC board, rev B, 2025-09-06, DCDC module |

## Current PCB (Rev 1.0) — Deprecated

| Field | Value |
|-------|-------|
| Version | Rev 1.0 |
| Status | **Deprecated** — do not fabricate |
| Schematic | `TC358870_DEMO.DSN` |
| Layout | `deprecated/tc358870_demo.brd` |
| Gerber | `deprecated/gerber/` |

### Known Errata

| # | Signal | Issue | Severity |
|---|--------|-------|----------|
| 1 | MIPI DSI lanes | Lane/clock pair order swapped vs. datasheet | **Critical** — damages LCD panel |
| 2 | HPDO (B4) | Shorted to VCC_HDMIRX_IN (+5V) | High |
| 3 | HPDI (A4) | Connected to HPD pin instead of +5V rail | Medium |

## Next PCB (Rev 2.0) — Planned

| Field | Value |
|-------|-------|
| Version | Rev 2.0 |
| Target file | `tb_demo-revA-YYMMDD-aio.brd` |
| Status | In design |

### Changes from Rev 1.0

| # | Change | Reason |
|---|--------|--------|
| 1 | **Swap MIPI DSI lane/clock pair order** | Fix screen burn (errata #1) |
| 2 | Fix HPDO trace — remove short to +5V, route via 1 KΩ to HPD | Fix errata #2 |
| 3 | Fix HPDI — route via 100 KΩ to +5V rail | Fix errata #3 |
| 4 | Add external EEPROM + I2C connector on DDC bus | Expandability |

## Screen Burn Issue

### Symptoms

- LCD panel developed **permanent pixel damage** (burn-in / image retention) immediately on first power-up with the Rev 1.0 board.
- Damage was visible as stuck bright/dark pixels and horizontal line artifacts that persisted across power cycles.
- Panel was irrecoverable — replacement panel required.

### Root Cause

The **MIPI DSI interface signal order was incorrect** on the Rev 1.0 PCB layout. One or more of the following were swapped relative to the TC358870XBG datasheet pin mapping:

- DSI data lane differential pairs (D0, D1, D2, D3)
- DSI clock lane differential pair
- Lane-to-lane ordering within a DSI link (DSI0 vs. DSI1)

Because the high-speed differential pairs carrying serialized pixel data were mapped to the wrong physical pins on the panel connector, the panel's internal ASIC received lane data on incorrect input pairs. This caused the ASIC's deserializer to reconstruct garbage pixel values and/or drive incorrect voltages to the LCD column/row drivers, permanently damaging the liquid crystal cells.

### Fix

Re-route all DSI data and clock differential pairs so that each lane index matches the pin mapping table in the TC358870XBG datasheet. Verify lane ordering in both the schematic symbol pin assignment and the PCB fanout before tape-out.

## Lessons Learned

### PCB Design

1. **Cross-check high-speed interface pinouts before routing.** A single swapped differential pair on MIPI DSI can permanently destroy the connected panel. Always verify the pin mapping (datasheet ball map → schematic symbol → PCB fanout) as a separate checklist step.
2. **Label differential pairs explicitly** in the schematic with lane/clock indices (e.g., `DSI0_D0_P`, `DSI0_CLK_N`) so the correct ordering is unambiguous during layout.
3. **Add series termination footprints** near the source for all high-speed lanes (even if populated with 0 Ω) to allow impedance tuning without a board re-spin.
4. **Keep a physical-layer review checklist** — verify schematic symbol ↔ datasheet ball map ↔ PCB fanout for every high-speed interface before sending the board out.

### Software / Firmware

1. **Implement a safe-startup handshake.** Initialize the DSI PHY in LP (Low Power) mode first, attempt link bring-up at the lowest data rate, and validate that the panel responds correctly before switching to HS (High Speed) mode.
2. **Add panel detection before enabling DSI output.** Read EDID or panel ID over I2C. Never drive a display output without first confirming what is connected.
3. **Log all register writes during init.** A dumped I2C register map would have made it immediately obvious that the physical lane mapping didn't match the logical configuration — reducing debug time from "replaced panel" to "checked log."
4. **Add a hardware-in-the-loop test** that validates DSI lane mapping with a known-good loopback or test pattern before connecting an actual panel.
