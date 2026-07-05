#ifndef __EDID_H__
#define __EDID_H__

#include "main.h"
#include "i2c.h"
#include "AT24C02.h"


typedef enum {
    EDID_STATUS_SUCCESS         =  0,   // 操作成功

    /* 硬件/通信层 (负数) */
    EDID_STATUS_NO_DEVICE       = -1,   // DDC 总线上无 EEPROM 响应
    EDID_STATUS_TIMEOUT         = -2,   // I2C 操作超时
    EDID_STATUS_READ_FAIL       = -3,   // EEPROM 读取失败
    EDID_STATUS_WRITE_FAIL      = -4,   // EEPROM 写入失败

    /* 数据结构校验 */
    EDID_STATUS_BAD_HEADER      = -100, // 固定头错误
    EDID_STATUS_BAD_CHECKSUM    = -101, // 主块校验和错误
    EDID_STATUS_BAD_BLOCK_COUNT = -102, // 扩展块数量不合法
    EDID_STATUS_BAD_BLOCK_CHECKSUM = -103, // 扩展块校验和错误

    /* 数据内容不合法 */
    EDID_STATUS_BAD_VERSION     = -200, // EDID 版本不合法
    EDID_STATUS_BAD_TIMING      = -201, // 时序参数不合法
    EDID_STATUS_BAD_DESCRIPTOR  = -202, // 描述符内容不合法
    EDID_STATUS_BAD_COLOR       = -203, // 色彩参数不合法

    /* 其他错误 */
    EDID_STATUS_UNKNOWN_ERROR   = -999, // 未知错误

    /* 降级状态 (正数) */
    EDID_STATUS_FALLBACK_USED   =  1,   // 已回退到内置默认 EDID
} EDID_StatusTypeDef;

EDID_StatusTypeDef EDID_Read(uint8_t *pEDID, uint16_t size);
EDID_StatusTypeDef EDID_Write(uint8_t *pEDID, uint16_t size);

#endif
