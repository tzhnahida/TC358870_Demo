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
