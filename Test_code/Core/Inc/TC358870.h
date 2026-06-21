/**
 * @file    TC358870.h
 * @brief   TC358870XBG HDMI → MIPI DSI 桥接芯片驱动
 *
 * TC358870XBG 将 HDMI TMDS 信号转换为 MIPI DSI 输出, 用于驱动 LCD 面板。
 * STM32F103 通过 I2C (I2C1) 配置芯片寄存器, 包括:
 *   - 系统时钟和模块复位
 *   - HDMI PHY 配置
 *   - DSI PLL 编程 (40MHz REFCLK → 400MHz DSI)
 *   - DCS 面板初始化命令 (LP 模式 LPTX)
 *   - HPD 热插拔控制
 *   - EDID 模式选择 (直通 DDC 总线上的 AT24C02 EEPROM)
 *
 * I2C 地址: 7-bit 0x0F (INT 引脚上拉) 或 0x1F (INT 下拉)
 *           本项目使用 0x0F, 对应 8-bit 写地址 0x1E / 读地址 0x1F
 *
 * @note   寄存器地址为 16-bit (big-endian), 因此不能使用 HAL_I2C_Mem_Write
 *         (仅支持 8-bit 内存地址), 改用 HAL_I2C_Master_Transmit/Receive 手动拼帧。
 */

#ifndef __TC358870_H__
#define __TC358870_H__

#include "main.h"
#include "i2c.h"


/* --------------------------------------------------------------------------
 * 硬件参数
 * -------------------------------------------------------------------------- */

#define TC358870_I2C           &hi2c1        /**< I2C 总线句柄 (I2C1 = HDMI 控制通道) */
#define TC358870_ADDRESS_7BIT  0x0F          /**< 芯片 7-bit 基地址 (INT 引脚上拉 → 0b0111101) */
#define TC358870_ADDRESS_Write 0x1E          /**< 8-bit 写地址 (0x0F << 1) */
#define TC358870_ADDRESS_Read  0x1F          /**< 8-bit 读地址 ((0x0F << 1) | 1) */




typedef enum {
    TC358870_Reg_8Bit = 8,   /**< 写 8-bit 寄存器 */
    TC358870_Reg_16Bit = 16, /**< 写 16-bit 寄存器 */
    TC358870_Reg_32Bit = 32, /**< 写 32-bit 寄存器 */
}TC358870_Reg_Bit;

/* --------------------------------------------------------------------------
 * 操作状态码
 *
 * 0 = 成功, 正数 = 降级 (正常但非完整功能), 负数 = 错误 (分层编码)
 * -------------------------------------------------------------------------- */

typedef enum {
    TC358870_STATUS_SUCCESS             =  0,   /**< 操作成功 */

    /* 硬件/通信层 (-1 ~ -99) */
    TC358870_STATUS_I2C_ERROR           = -1,   /**< I2C 通信错误 */
    TC358870_STATUS_TIMEOUT             = -2,   /**< 操作超时 (PLL 锁定 / TMDS 检测等) */
    TC358870_STATUS_NO_DEVICE           = -3,   /**< 芯片无响应 (ChipID 读不到) */
    TC358870_STATUS_INVALID_PARAM        = -4,   /**< 参数无效 (寄存器地址 / 数据长度等) */

    /* 初始化错误 (-100 ~ -199) */
    TC358870_STATUS_BAD_CHIPID          = -100, /**< ChipID 不匹配 (非 0x0047) */
    TC358870_STATUS_PLL_FAIL            = -101, /**< DSI PLL 锁定失败 */
    TC358870_STATUS_REFCLK_INVALID      = -102, /**< REFCLK 频率异常 (SYS_FREQ 读数不合理) */
    TC358870_STATUS_HDMI_NOT_READY      = -103, /**< HDMI 源端未就绪 (TMDS / 5V 未检测) */
    TC358870_STATUS_SYSCLK_FAIL         = -104, /**< 系统时钟未稳定 */

    /* DCS/面板通信 (-200 ~ -299) */
    TC358870_STATUS_LPTX_FAIL           = -200, /**< LP 模式命令发送失败 */
    TC358870_STATUS_DCS_ERROR           = -201, /**< 面板 DCS 命令返回错误 */

    /* 其他 */
    TC358870_STATUS_UNKNOWN_ERROR       = -999, /**< 未知错误 */

    /* 降级状态 (正数) */
    TC358870_STATUS_NO_HDMI              =  1,  /**< HDMI 未连接, DSI 关闭 (正常待机) */
} TC358870_StatusTypeDef;


/* --------------------------------------------------------------------------
 * API — I2C 寄存器读写
 *
 * 注意: DevAddress 参数传入 8-bit 地址 (0x1E / 0x1F),
 *       HAL_I2C_Master_Transmit/Receive 内部会自动处理 R/W 位。
 * -------------------------------------------------------------------------- */

/** @brief 写 8-bit 寄存器 */
HAL_StatusTypeDef TC358870_WriteReg_8Bit(uint16_t dev_address, uint16_t reg_addr, uint8_t data);
/** @brief 读 8-bit 寄存器 */
HAL_StatusTypeDef TC358870_ReadReg_8Bit(uint16_t dev_address, uint16_t reg_addr, uint8_t *data);
/** @brief 写 16-bit 寄存器 (big-endian) */
HAL_StatusTypeDef TC358870_WriteReg_16Bit(uint16_t dev_address, uint16_t reg_addr, uint16_t data);
/** @brief 读 16-bit 寄存器 (big-endian) */
HAL_StatusTypeDef TC358870_ReadReg_16Bit(uint16_t dev_address, uint16_t reg_addr, uint16_t *data);
/** @brief 写 32-bit 寄存器 (big-endian, 保留 API) */
HAL_StatusTypeDef TC358870_WriteReg_32Bit(uint16_t dev_address, uint16_t reg_addr, uint32_t data);
/** @brief 读 32-bit 寄存器 (big-endian, 保留 API) */
HAL_StatusTypeDef TC358870_ReadReg_32Bit(uint16_t dev_address, uint16_t reg_addr, uint32_t *data);

/** @brief 写寄存器 (统一接口, 含 ACK 轮询 + 读回校验 + 重试) */
TC358870_StatusTypeDef TC358870_WriteReg(uint16_t DevAddress, uint16_t regAddr, uint32_t data, TC358870_Reg_Bit size);

/** @brief 读寄存器 (统一接口, 结果存入 uint32_t) */
TC358870_StatusTypeDef TC358870_ReadReg(uint16_t DevAddress, uint16_t regAddr, uint32_t *data, TC358870_Reg_Bit size);

#endif /* __TC358870_H__ */
