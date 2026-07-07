/**
 * @file    EDID.c
 * @brief   EDID 处理模块实现 — 读取、写入、校验
 *
 * EDID 数据存储在 HDMI DDC 总线上的 AT24C02 EEPROM 中。
 * 校验流程: 固定头 → 主块校验和 → 扩展块数量 → 各扩展块校验和
 */

#include "EDID.h"


/**
 * @brief  从 EEPROM 读取 EDID 数据
 * @param  pEDID  读取数据存放缓冲区
 * @param  size   期望读取的字节数 (128 或 256)
 * @retval EDID_STATUS_SUCCESS  读取成功
 * @retval EDID_STATUS_READ_FAIL  I2C 读取失败
 */
EDID_StatusTypeDef EDID_Read(uint8_t *pEDID, uint16_t size)
{
    HAL_StatusTypeDef status = HAL_OK;
    status = AT24C02_Read(AT24C02_ADDRESS_Read, 0x00, pEDID, size);
    if (status != HAL_OK)
    {
        return EDID_STATUS_READ_FAIL;
    }
    return EDID_STATUS_SUCCESS;
}


/**
 * @brief  将 EDID 数据写入 EEPROM
 * @param  pEDID  待写入数据缓冲区
 * @param  size   写入字节数 (128 或 256)
 * @retval EDID_STATUS_SUCCESS   写入成功 (含逐字节校验)
 * @retval EDID_STATUS_WRITE_FAIL  I2C 写入失败或校验失败
 *
 * @note   AT24C02_Write 内部调用 WriteByte, 每字节写入后 ACK 轮询等待
 *         写周期 + 读回比对校验, 失败自动重试 MAX_RETRIES 次。
 */
EDID_StatusTypeDef EDID_Write(uint8_t *pEDID, uint16_t size)
{
    HAL_StatusTypeDef status = HAL_OK;
    status = AT24C02_Write(AT24C02_ADDRESS_Write, 0x00, pEDID, size);
    if (status != HAL_OK)
    {
        return EDID_STATUS_WRITE_FAIL;
    }
    return EDID_STATUS_SUCCESS;
}


/**
 * @brief  校验 EDID 数据完整性
 *
 * 校验流程:
 *   1. 最小大小 ≥ 128 字节
 *   2. 固定头 (00 FF FF FF FF FF FF 00)
 *   3. 主块校验和 — 前 128 字节累加 mod 256 应为 0
 *   4. 扩展块数量 — Byte[126] 不超过 EDID_MAX_EXTENSIONS
 *   5. 数据长度 — 需覆盖所有声明的扩展块
 *   6. 各扩展块校验和 — 每 128 字节独立校验
 *
 * @param  pEDID  EDID 数据缓冲区指针
 * @param  size   缓冲区实际大小 (字节)
 * @retval EDID_STATUS_SUCCESS              全部校验通过
 * @retval EDID_STATUS_BAD_SIZE             数据不足
 * @retval EDID_STATUS_BAD_HEADER           头不匹配
 * @retval EDID_STATUS_BAD_CHECKSUM         主块校验和错误
 * @retval EDID_STATUS_BAD_BLOCK_COUNT      扩展块数量超限
 * @retval EDID_STATUS_BAD_BLOCK_CHECKSUM   扩展块校验和错误
 */
EDID_StatusTypeDef EDID_Validate(uint8_t *pEDID, uint16_t size)
{
    // 1. 最小大小检查
    if (size < 128) {
        return EDID_STATUS_BAD_SIZE;
    }

    // 2. 固定头校验 (前 8 字节必须匹配)
    static const uint8_t HEADER[8] = {
        0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00
    };
    if (memcmp(pEDID, HEADER, 8) != 0) {
        return EDID_STATUS_BAD_HEADER;
    }

    // 3. 主块校验和 (Byte 0-127 累加, 结果应为 0)
    uint8_t checksum = 0;
    for (uint16_t i = 0; i < 128; i++) {
        checksum += pEDID[i];
    }
    if (checksum != 0) {
        return EDID_STATUS_BAD_CHECKSUM;
    }

    // 4. 扩展块数量合法性 (Byte[126])
    uint8_t extensionCount = pEDID[126];
    if (extensionCount > EDID_MAX_EXTENSIONS) {
        return EDID_STATUS_BAD_BLOCK_COUNT;
    }
    if (size < (uint16_t)(extensionCount + 1) * 128) {
        return EDID_STATUS_BAD_SIZE;
    }

    // 5. 各扩展块校验和 (每 128 字节独立校验)
    for (uint8_t block = 1; block <= extensionCount; block++) {
        uint8_t blockChecksum = 0;
        uint16_t offset = (uint16_t)block * 128;
        for (uint16_t i = 0; i < 128; i++) {
            blockChecksum += pEDID[offset + i];
        }
        if (blockChecksum != 0) {
            return EDID_STATUS_BAD_BLOCK_CHECKSUM;
        }
    }

    return EDID_STATUS_SUCCESS;
}


/**
 * @brief  LS029B3SX01 LCD 面板 EDID (256 字节, EDID 1.3)
 *
 * 面板:  Sharp LS029B3SX01, 2.89" CG-Silicon TFT
 * 驱动:  NT35597 (内置 NVM 自动加载寄存器)
 * 分辨率:  1440 × 1440 (1:1 方形)
 * 像素时钟: 261.6 MHz
 * 时序:    H Total=1694, V Total=1712
 * 刷新率:  90.2 Hz
 * 接口:    数字, MIPI DSI 双端口 (via TC358870)
 *
 * 来源: LS029B3SX01 数据手册 (LCY-1315802C Rev.C), EDID 编辑器生成。
 * 校验: Block0 Checksum=0x19, Block1 Checksum=0x54 (已验证)
 */
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
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x54,
};

/**
 * @brief  EDID 初始化 — 从 EEPROM 读取并校验, 失败则回退到内置模板
 *
 * 流程:
 *   1. 从 AT24C02 读取 256 字节 EDID
 *   2. 校验 EDID 完整性 (头/校验和/扩展块)
 *   3. 校验通过 → 返回 EDID_STATUS_SUCCESS
 *   4. 校验失败 → 将内置模板 edid_ls029b3sx01 写入 EEPROM
 *   5. 写入成功 → 返回 EDID_STATUS_FALLBACK_USED (降级)
 *
 * @retval EDID_STATUS_SUCCESS         EEPROM 中 EDID 有效, 无需干预
 * @retval EDID_STATUS_FALLBACK_USED   EDID 无效, 已用内置模板覆盖
 * @retval EDID_STATUS_READ_FAIL       EEPROM 读取失败 (总线异常)
 * @retval EDID_STATUS_WRITE_FAIL      EEPROM 写入失败 (总线异常)
 *
 * @note   此函数应在 TC358870 复位释放前调用, 确保 DDC 总线上存在
 *         有效 EDID 后再设 EDID_MODE=0x00 直通给 HDMI 源端。
 */
EDID_StatusTypeDef EDID_Init(void)
{
    EDID_StatusTypeDef status = EDID_STATUS_SUCCESS;
    uint8_t edidBuffer[256] = {0};
    status = EDID_Read(edidBuffer, sizeof(edidBuffer));
    if (status != EDID_STATUS_SUCCESS)
    {
        return status;
    }
    status = EDID_Validate(edidBuffer, sizeof(edidBuffer));
    if (status == EDID_STATUS_SUCCESS)
    {
        return status; // EDID 有效, 直接使用
    }

    // EDID 无效, 用内置模板覆盖 EEPROM
    status = EDID_Write((uint8_t *)edid_ls029b3sx01, sizeof(edid_ls029b3sx01));
    if (status != EDID_STATUS_SUCCESS)
    {
        return status; // 写入失败, 无法恢复
    }
    return EDID_STATUS_FALLBACK_USED; // 已回退到内置模板
}
