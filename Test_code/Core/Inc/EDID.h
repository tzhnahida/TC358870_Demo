/**
 * @file    EDID.h
 * @brief   EDID (Extended Display Identification Data) 处理模块
 *
 * 负责 EDID 数据的读取、写入和校验。EDID 数据存储在 HDMI DDC 总线
 * 上的 AT24C02 EEPROM 中, TC358870 在 EDID_MODE=0x00 时将其直通给
 * HDMI 源端读取。
 *
 * EDID 结构 (每块 128 字节):
 *   - Byte 0-7:   固定头 (00 FF FF FF FF FF FF 00)
 *   - Byte 8-17:  厂商/产品信息
 *   - Byte 18-19: EDID 版本 (通常 1.3 或 1.4)
 *   - Byte 20-24: 基本显示参数
 *   - Byte 25-34: 色度坐标
 *   - Byte 35-37: 支持的时序
 *   - Byte 38-53: 标准时序 (8 组)
 *   - Byte 54-125: 详细时序描述符 (4 组, 18 字节/组)
 *   - Byte 126:    扩展块数量
 *   - Byte 127:    主块校验和 (前 128 字节累加 ≡ 0 mod 256)
 */

#ifndef __EDID_H__
#define __EDID_H__



#include "main.h"
#include "i2c.h"
#include "AT24C02.h"


/* --------------------------------------------------------------------------
 * EEPROM 容量 → EDID 块数映射
 *
 * 每个 EDID 块为 128 字节。AT24C02 总容量 256 字节 = 2 块 (1 基础 + 1 扩展)。
 * 本项目使用 AT24C02, 通过 EDID_TOTAL_BLOCKS 宏指定。
 * -------------------------------------------------------------------------- */

typedef enum {
    EDID_BLOCKS_AT24C02 = 2,   /**< AT24C02: 2K-bit (256B) → 2 块 */
    EDID_BLOCKS_AT24C04 = 4,   /**< AT24C04: 4K-bit (512B) → 4 块 */
    EDID_BLOCKS_AT24C08 = 8,   /**< AT24C08: 8K-bit (1KB)  → 8 块 */
    EDID_BLOCKS_AT24C16 = 16,  /**< AT24C16: 16K-bit (2KB) → 16 块 */
} EDID_BlocksTypeDef;

#define EDID_TOTAL_BLOCKS   EDID_BLOCKS_AT24C02  /**< 当前使用的 EEPROM 对应的 EDID 总块数 */
#define EDID_MAX_EXTENSIONS (EDID_TOTAL_BLOCKS - 1) /**< 最大扩展块数 (基础块不计入) */


/* --------------------------------------------------------------------------
 * EDID 操作状态码
 *
 * 0 = 成功, 正数 = 降级, 负数 = 错误 (分层编码)
 * -------------------------------------------------------------------------- */

typedef enum {
    EDID_STATUS_SUCCESS         =  0,   /**< 操作成功, EDID 完整有效 */

    /* 硬件/通信层 (-1 ~ -99) */
    EDID_STATUS_NO_DEVICE       = -1,   /**< DDC 总线上无 EEPROM 响应 */
    EDID_STATUS_TIMEOUT         = -2,   /**< I2C 操作超时 */
    EDID_STATUS_READ_FAIL       = -3,   /**< EEPROM 读取失败 */
    EDID_STATUS_WRITE_FAIL      = -4,   /**< EEPROM 写入失败 */

    /* 数据结构校验 (-100 ~ -199) */
    EDID_STATUS_BAD_HEADER          = -100, /**< 固定头错误 (前 8 字节不匹配) */
    EDID_STATUS_BAD_CHECKSUM        = -101, /**< 主块校验和错误 (Byte0-127 sum%256 ≠ 0) */
    EDID_STATUS_BAD_BLOCK_COUNT     = -102, /**< 扩展块数量超过 EEPROM 容量上限 */
    EDID_STATUS_BAD_BLOCK_CHECKSUM  = -103, /**< 某个扩展块校验和错误 */
    EDID_STATUS_BAD_SIZE            = -104, /**< 数据长度不足 (短于所需块数×128) */

    /* 其他 */
    EDID_STATUS_UNKNOWN_ERROR   = -999, /**< 未知错误 */

    /* 降级状态 (正数) */
    EDID_STATUS_FALLBACK_USED   =  1,   /**< 原始 EDID 无效, 已回退到内置 EDID 模板 */
} EDID_StatusTypeDef;




/* --------------------------------------------------------------------------
 * API 函数
 * -------------------------------------------------------------------------- */

/** @brief 从 EEPROM 读取 EDID 数据 */
EDID_StatusTypeDef EDID_Read(uint8_t *pEDID, uint16_t size);

/** @brief 将 EDID 数据写入 EEPROM (含逐字节校验) */
EDID_StatusTypeDef EDID_Write(const uint8_t *pEDID, uint16_t size);

/** @brief 校验 EDID 数据完整性 (头/校验和/扩展块) */
EDID_StatusTypeDef EDID_Validate(const uint8_t *pEDID, uint16_t size);

/** @brief EDID 初始化: 读 EEPROM → 校验 → 无效则回退内置模板 */
EDID_StatusTypeDef EDID_Init(void);


extern const uint8_t edid_ls029b3sx01[256]; /**< 内置 LS029B3SX01 LCD 面板 EDID 模板 */

#endif /* __EDID_H__ */
