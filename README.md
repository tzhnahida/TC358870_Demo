# TC358870XBG HDMI-to-MIPI DSI Bridge — Evaluation Board

> **PCB Rev 1.0 is deprecated.** Do not fabricate. MIPI DSI lane swap errata + HPD wiring errors.
> **Rev 2.0:** Layout complete. SI/PI simulation pending.

A 4-layer PCB for the Toshiba TC358870XBG, converting HDMI 1.4b (up to 297 MHz TMDS) to dual 4-lane MIPI DSI (up to 1 Gbps/lane). Designed to drive a Sharp LS029B3SX01 1440×1440@90Hz LCD panel.

---

## Hardware

### Key Components

| Designator | Part | Function |
|-----------|------|----------|
| U1 | TYPE-C 16-pin | 5V power input (USB-C) |
| U2 | TLV62569DBV | 5V→3.3V DCDC buck (VCC_3V3) |
| U3 | LP5907MFX | 3.3V→1.2V LDO (VCC_1V2) |
| U4 | TLV62569DBV | 5V→1.1V DCDC buck (VCC_1V1) |
| U5 | LP5907MFX | 3.3V→1.8V LDO (VCC_1V8) |
| U6 | TPS65131RGER | 5V→±5.5V charge pump (panel AVDD/AVEE) |
| U7 | SGM3752YTN6G | 3.3V→LED backlight boost (22mA max) |
| U8 | AT24C02 (SOP-8) | DDC EEPROM, EDID storage |
| U9A/B/C/D | TC358870XBG (BGA80) | HDMI Rx → dual MIPI DSI Tx (4-page schematic) |
| ESD1/2/3 | IP4292CZ10 | HDMI ESD protection |
| Q1 | PMOS | Power switch |
| OSC1 | 40 MHz | REFCLK for TC358870 |
| J1 | HDMI-A | HDMI input connector |
| J2 | WP7 (JAE 40-pin) | Panel FPC, mates with LS029B3SX01 |

### Power Rails

| Rail | Voltage | Source | Load |
|------|---------|--------|------|
| VCC_5V | 5.0V | USB-C | Input bus |
| VCC_3V3 | 3.3V | 5V→3.3V DCDC buck (TLV62569) | TC358870 VDDIO33, VDD33_HDMI; feeds LDOs + LED |
| VCC_1V8 | 1.8V | 3.3V→1.8V LDO (LP5907) | TC358870 VDDIO18 |
| VCC_1V2 | 1.2V | 3.3V→1.2V LDO (LP5907) | TC358870 VDD12_MIPI0/1 |
| VCC_1V1 | 1.1V | 5V→1.1V DCDC buck (TLV62569) | TC358870 VDDC11, VDD11_HDMI |
| VCC_5V5 | +5.5V | 5V charge pump (TPS65131) | LS029 AVDD+ |
| VEE_5V5 | -5.5V | 5V charge pump (TPS65131) | LS029 AVEE- |
| VCC_HDMIRX_IN | +5V (from HDMI source) | HDMI pin 18 | DDC pull-up |

### PCB Stack-Up (4-layer)

| Layer | Type |
|-------|------|
| TOP | Signal (HDMI, MIPI, I2C, REFCLK) |
| L2 | Solid GND plane |
| L3 | Split POWER plane |
| BOTTOM | Signal, decoupling, test points |

---

## Known Issues

### AT24C256 → AT24C02 ✅ Resolved in Schematic

Schematic symbol value updated to AT24C02 (2026-06-29). Original AT24C256 uses **2-byte I2C addressing** — incompatible with HDMI DDC which only sends 1 address byte for EDID reads. AT24C02 uses same SOP-8 footprint and 1-byte addressing (¥0.5). PCB footprint unchanged. Library symbol name still shows "AT24C256" but BOM and silk-screen will read AT24C02.

### EDID: External EEPROM Only

TC358870 contains 1 KB internal EDID SRAM, but **its I2C sub-address is not documented in the public datasheet** (`TC358870XBG_rev1.3.pdf`). Use external AT24C02 on the DDC bus with `EDID_MODE = 0x00` (DDC passthrough to EEPROM).

### Rev 1.0 Errata

| Signal | Issue | Fix |
|--------|-------|-----|
| MIPI DSI lanes | Lane/clock pair order swapped per datasheet | Re-route per pin mapping |
| HPDO (B4) | Shorted to +5V | Cut trace, add 1kΩ to HDMI pin 19 |
| HPDI (A4) | Connected to HPD pin | Move to HDMI pin 18 (+5V) via 100kΩ |

---

## EDID

The board ships with a 256-byte EDID for LS029B3SX01 (1440×1440@90.2Hz). Flash this to the AT24C02 via the DDC bus (STM32 can take control while TC358870 is held in reset):

```c
const uint8_t edid_ls029b3sx01[256] = {
    0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,
    0x4D,0x10,0x02,0x29,0x01,0x00,0x00,0x00,
    0x1A,0x24,0x01,0x03,0x80,0x34,0x34,0x78,
    0xEE,0x91,0x50,0x54,0x9C,0x27,0x0E,0x50,
    0x54,0xBF,0xEF,0x00,0x00,0x00,0x01,0x01,
    0x01,0x01,0x01,0x01,0x01,0x01,0x01,0x01,
    0x01,0x01,0x01,0x01,0x01,0x01,0x2F,0x66,
    0xA0,0xFE,0x50,0xA0,0x10,0x51,0x9A,0x04,
    0xF1,0xC0,0x34,0x34,0x10,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0xFD,0x00,0x32,
    0x5E,0x14,0xA0,0x1E,0x00,0x00,0x00,0x00,
    0x00,0x0A,0x00,0x00,0x00,0x00,0x00,0xFC,
    0x00,0x4C,0x53,0x30,0x32,0x39,0x42,0x33,
    0x53,0x58,0x30,0x31,0x00,0x00,0x01,0x19,
    0x02,0x03,0x0E,0x00,0x21,0x01,0x67,0x00,
    0x0C,0x03,0x01,0x00,0x00,0x00,0x00,0x00,
    // ... (see wiki LS029B3SX01.md for full verified array)
};
// Checksums: Block0=0x19, Block1=0x54
// 1440×1440, 261.6 MHz pixel clock, 90.2 Hz
```

---

## Firmware

### Register Initialization Sequence

The STM32 (or any I2C master at 0x0F/0x1F) must write this sequence at power-up:

```
 1. SYSCTL     (0x0002) = 0x3F01   // full reset + SLEEP, delay 1ms
 2. SYSCTL     (0x0002) = 0x0000   // release
 3. ConfCtl0   (0x0004) = 0x0004   // AutoIndex=1
 4. ConfCtl1   (0x0006) = 0x0008   // dcs_clks=1
 5. SYS_FREQ0  (0x8540) = ...      // REFCLK_Hz / 10000  LSB
 6. SYS_FREQ1  (0x8541) = ...      // REFCLK_Hz / 10000  MSB
 7. EDID_MODE  (0x85E0) = 0x00     // DDC passthrough to external EEPROM
 8. DDCIO_CTL  (0x84F4): 0→1      // DDC I/O power-up edge
 9. DDC_CTL    (0x8543) = 0x04     // DDC_ACTION=1
10. PHY_ENB    (0x8413) |= 0x01    // exit Suspend
11. PHY_RSTX   (0x8414) |= 0x01    // release PHY reset
12. VOUT_FMT   (0x8A00) = 0x00     // RGB output
13. VOUT_CSC   (0x8A08) = 0x00     // no CSC
14. ConfCtl0   (0x0004) = 0x0007   // Vtx0_en + Vtx1_en + AutoIndex
15. INIT_END   (0x854A) = 0x01     // init complete
16. HPD_CTL    (0x8544) = 0x01     // assert HPD
```

### DSI Configuration (40 MHz REFCLK, 800 Mbps/lane target)

```
MIPI_PLL_CONF (0x02AC) = 0x0003793F  // {0x3F,0x79,0x03,0x00}
//   FBD=319, PRD=7, FRS=2, LBW=max
//   pll_clk = 40MHz × 320/8 / 4 = 400 MHz → 800 Mbps/lane

MIPI_PLL_CTRL (0x02A0) = 0x03        // MP_ENABLE + MP_CKEN
while (!(read(0x02A8) & 0x01));       // wait for PLL lock

PPI_DPHY_POWERCNTRL (0x0284) = 0x1F
DSITX_CLKEN   (0x0108)  = 0x01
MODE_CONFIG   (0x0110)  = 0x16    // IndMode=1, HSYNC/VSYNC active-low
FUNC_MODE     (0x0150)  = 0x00    // discontinuous clock, no EoT
DSITX_MODE    (0x017C)  = 0x00    // LP blanking, pulse mode
LANE_ENABLE   (0x0118)  = 0x1F    // CK + D0-D3 all lanes
DSI_HSYNC_WIDTH (0x018C) = 0x0004
DSI_HBPR      (0x0190) = 0x0092
```

### Panel DCS Initialization

LS029B3SX01 uses an NT35597 driver IC with NVM pre-programmed by Sharp. Only 5 DCS commands needed (sent via TC358870 LPTX registers in LP mode, before video starts):

| Step | Command | Data Type | Wait |
|------|---------|-----------|------|
| 1 | `0xFF 0x10` | DCS Short Write 1p (0x15) | — |
| 2 | `0x11` (Sleep Out) | DCS Short Write 0p (0x05) | ≥100ms |
| 3 | `0xFF 0x10` | DCS Short Write 1p (0x15) | — |
| 4 | `0x29` (Display On) | DCS Short Write 0p (0x05) | ≥40ms |

LPTX register sequence per command:
```c
LPTX_TYPE        (0x022C) = 0x00000384;   // Trigger0, LPDT=1, ALL lanes
DSI_LPTX_PKT_HDR (0x0230) = <packed DT+WC>; // e.g. 0x10FF0015 for DT=0x15, cmd=0xFF
DSI_LPTX_REQ     (0x0228) = 0x01;
while (!(read(0x0220) & 0x01));            // wait LpTxDone
write(0x0220) = 0x01;                      // clear
```

After DCS commands complete, start HS video:
```c
DSITX_START (0x011C) = 0x01;
```

### Panel Hardware Power-Up (MCU GPIO control, before DCS)

```
1. XRES = L (assert reset)
2. IOVDD 1.8V ON → wait stable
3. AVDD+ 5.5V ON → wait >1ms
4. AVDD- -5.5V ON → wait >10ms
5. XRES = H → ≥20µs → L → ≥20µs → H
6. Wait ≥10ms (NVM auto-load)
```

---

## Key Registers Reference

Full register documentation is in `TC358870XBG_rev1.3.pdf` (311 pages). See wiki `TC358870.md` for the complete register map with bit-level definitions.

| Address | Register | Summary |
|---------|----------|---------|
| `0x0000` | ChipID | RO, `0x0047` |
| `0x0002` | SysCtl | Reset bits [13:6], SLEEP [0] |
| `0x0004` | ConfCtl0 | Vtx0_en [0], Vtx1_en [1], AutoIndex [2] |
| `0x0006` | ConfCtl1 | dcs_clks [3] |
| `0x0108` | DSITX_CLKEN | DSI0 clock enable |
| `0x0110` | MODE_CONFIG | IndMode [4], HSYNC_POL [2], VSYNC_POL [1] |
| `0x0118` | LANE_ENABLE | Lane enable [4:0] = CK/D0/D1/D2/D3 |
| `0x011C` | DSITX_START | Write 1 to start video |
| `0x0150` | FUNC_MODE | HsCkMd [5], EoTpEn [0] |
| `0x017C` | DSITX_MODE | BlankPkt_En [7], DSITXMd [0] |
| `0x018C` | DSI_HSYNC_WIDTH | HSA in bytes |
| `0x0190` | DSI_HBPR | HBP in bytes |
| `0x0220-0x0238` | LPTX regs | LP-mode DCS command transmission |
| `0x0284` | PPI_DPHY_POWERCNTRL | D-PHY lane power |
| `0x02A0` | MIPI_PLL_CTRL | MP_ENABLE, MP_CKEN |
| `0x02A8` | MIPI_PLL_LOCK | RO, bit[0]=1 when locked |
| `0x02AC` | MIPI_PLL_CONF | FBD[8:0], PRD[3:0], FRS[1:0], LBW[1:0] |
| `0x5000` | STX0_CTRL | Splitter control (manual/auto) |
| `0x500C` | STX0_FPX | STX0 first pixel (0-4095) |
| `0x500E` | STX0_LPX | STX0 last pixel |
| `0x508C` | STX1_FPX | STX1 first pixel |
| `0x508E` | STX1_LPX | STX1 last pixel |
| `0x8410` | PHY_CTL | PHYCtl [0]: 0=manual, 1=auto |
| `0x8413` | PHY_ENB | PHYEnb [0] |
| `0x8414` | PHY_RSTX | PHY reset [0] |
| `0x84F4` | DDCIO_CTL | DDCPWR [0]: 0→1 edge required |
| `0x8520` | SYS_STATUS | S_DDC5V [0], S_TMDS [1], S_PHY_SCDT [3] |
| `0x8540-0x8541` | SYS_FREQ | REFCLK_Hz / 10000 |
| `0x8543` | DDC_CTL | DDC_ACTION [2], DDC5V_MODE [1:0] |
| `0x8544` | HPD_CTL | HPD_CTL0 [1], HPD_OUT0 [0] |
| `0x854A` | INIT_END | Write 0x01 to complete init |
| `0x85E0` | EDID_MODE | 00=external EEPROM, 01=internal+DDC2B, 1x=internal+E-DDC |
| `0x85E3` | EDID_LEN1 | EDID length [7:0] |
| `0x85E4` | EDID_LEN2 | EDID length [10:8] |
| `0x8A00` | VOUT_FMT | VOUT_SEL [1:0] |
| `0x8A08` | VOUT_CSC | VOUT_COLOR_SEL [6:4], CSC_Mode [1:0] |

---

## Files

| File | Description |
|------|-------------|
| `TC358870_DEMO.DSN` | OrCAD Capture schematic (4 pages) |
| `TC358870_DEMO.EDF` | EDIF schematic export (plain text) |
| `TC358870_Demo.opj` | OrCAD project |
| `TC358870_DEMO.pdf` | Schematic PDF |
| `allegro/tc358870_demo.brd` | Allegro PCB layout (Rev 2.0) |
| `allegro/tc358870_demo.ipc` | IPC-D-356A netlist for bare-board testing |
| `allegro/signoise.run/cases.cfg` | Cadence SigNoise simulation config |
| `Test_code/` | STM32F103 firmware (Keil MDK-ARM) |

---

## Panel

| Parameter | Value |
|-----------|-------|
| Model | Sharp LS029B3SX01 |
| Resolution | 1440×1440 |
| Refresh | 90.2 Hz |
| Interface | MIPI DSI dual 4-lane |
| DSI rate | 784.8 Mbps/lane |
| Driver IC | NT35597 (NVM pre-configured) |
| Connector | JAE WP7B-P040VA1 (40-pin B2B) |

See wiki `LS029B3SX01.md` for full datasheet parameters, DCS init sequence, DSI timing, and EDID binary.

---

## License

Apache 2.0. See [LICENSE](LICENSE).
