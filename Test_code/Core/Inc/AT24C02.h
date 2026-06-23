/**
 * @file    AT24C02.h
 * @brief   AT24C02 2K-bit (256x8) I2C EEPROM 驱动头文件
 *
 * AT24C02 挂载在 HDMI DDC 总线 (I2C2) 上, 用于存储 EDID 数据。
 * TC358870 在 EDID_MODE=0x00 时将 DDC 直通给 HDMI 源端, 由源端通过
 * DDC 总线读取本 EEPROM 中的 EDID 信息。
 *
 * 写保护: WP 引脚拉低时允许写入, 拉高时只读。
 */

#ifndef __AT24C02_H__
#define __AT24C02_H__

#include "main.h"
#include "i2c.h"

/* --------------------------------------------------------------------------
 * 硬件参数
 * -------------------------------------------------------------------------- */

#define AT24C02_I2C           &hi2c2        /**< 挂载的 I2C 总线句柄 (I2C2 = DDC) */
#define AT24C02_ADDRESS_7BIT  0x50          /**< 芯片 7-bit 基地址 (A2/A1/A0 接 GND → 0b000) */
#define AT24C02_ADDRESS_Write 0xA0          /**< 8-bit 写地址 (0x50 << 1) */
#define AT24C02_ADDRESS_Read  0xA1          /**< 8-bit 读地址 ((0x50 << 1) | 1) */
#define EEPROM_Size           256           /**< 芯片总容量 (字节), EDID 标准块仅用前 128 字节 */

/* --------------------------------------------------------------------------
 * 操作参数
 * -------------------------------------------------------------------------- */

#define MAX_RETRIES       3                 /**< WriteByte 读回校验失败最大重试次数 */
#define I2C_TIMEOUT       1000              /**< I2C 读写操作超时 (ms) */
#define ACK_POLL_TIMEOUT  5                 /**< ACK 轮询单次超时 (ms), AT24C02 写周期 ≤5ms */

/* --------------------------------------------------------------------------
 * API 函数
 *
 * 注意: HAL_I2C_Mem_Write / Mem_Read 的 DevAddress 参数接收 8-bit 地址,
 *       即 7-bit 基地址左移 1 位后的值 (0xA0 / 0xA1)。
 *       HAL 库内部会 & 0xFE 清除 R/W 位, 再根据读写方向自行设置，
 *       因此传 AT24C02_ADDRESS_Write 或 AT24C02_ADDRESS_Read 均可, 无需区分。
 * -------------------------------------------------------------------------- */

/** @brief 写入单字节 — 含 ACK 轮询 + 读回校验 + 重试 (MAX_RETRIES 次) */
HAL_StatusTypeDef AT24C02_WriteByte(uint16_t DevAddress, uint16_t MemAddress, const uint8_t *pData);

/** @brief 连续写入多字节 — 逐字节调用 WriteByte (校验和重试由 WriteByte 负责) */
HAL_StatusTypeDef AT24C02_Write(uint16_t DevAddress, uint16_t MemAddress, const uint8_t *pData, uint16_t Size);

/** @brief 连续读取多字节 — Sequential Read 一次读取, 芯片内部地址自动递增 */
HAL_StatusTypeDef AT24C02_Read(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size);

#endif /* __AT24C02_H__ */
