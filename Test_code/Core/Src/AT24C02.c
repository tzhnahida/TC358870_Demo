/**
 * @file    AT24C02.c
 * @brief   AT24C02 2K-bit (256x8) I2C EEPROM 驱动
 *
 * 本项目中 AT24C02 挂载在 HDMI DDC 总线上，用于存储 EDID 数据。
 * TC358870 在 EDID_MODE=0x00 时将 DDC 总线直通给 HDMI 源端读取。
 *
 * @note   芯片特性:
 *         - I2C 7-bit 基地址 0x50 (A2/A1/A0 引脚决定低 3 位)
 *         - 8 字节页写缓冲区 (Page Write)
 *         - 写周期 ≤ 5ms (字节写后需等待，页写同样)
 *         - 1 字节内存地址 (I2C_MEMADD_SIZE_8BIT)
 *         - 总容量 256 字节 (HDMI EDID 标准块为 128 字节)
 */

#include "AT24C02.h"


/**
 * @brief  向 AT24C02 写入单个字节 (带 ACK 轮询 + 读回校验 + 重试)
 *
 * 写入流程:
 *   1. HAL_I2C_Mem_Write — 发送写命令和数据
 *   2. HAL_I2C_IsDeviceReady — ACK 轮询, 等待内部写周期 (≤5ms) 结束
 *   3. HAL_I2C_Mem_Read  — 读回同一地址, 与写入值比对校验
 *   4. 校验失败则重试, 最多 MAX_RETRIES 次
 *
 * @param  DevAddress  I2C 8-bit 设备地址 (7-bit 地址 0x50 左移 1 位后的值)
 *                     传入头文件宏: AT24C02_ADDRESS_Write (0xA0) 或 AT24C02_ADDRESS_Read (0xA1)
 *                     HAL 库内部根据读写方向设置 R/W 位, 调用方无需区分
 * @param  MemAddress  片内存储地址 (0x00 ~ 0xFF)
 * @param  pData       待写入数据的指针
 * @retval HAL_OK       写入且校验成功
 * @retval HAL_ERROR    校验失败, 超过最大重试次数
 * @retval 其他          I2C 总线错误 (HAL_ERROR / HAL_TIMEOUT / HAL_BUSY)
 */
HAL_StatusTypeDef AT24C02_WriteByte(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData)
{
  HAL_StatusTypeDef status = HAL_OK;
  uint8_t readData;
  int retryCount = 0;
  do
  {
    status = HAL_I2C_Mem_Write(AT24C02_I2C, DevAddress, MemAddress, I2C_MEMADD_SIZE_8BIT, pData, 1, I2C_TIMEOUT);
    if (status != HAL_OK)
    {
      return status;
    }

    Write_BACK:
    status = HAL_I2C_IsDeviceReady(AT24C02_I2C, DevAddress, 3, ACK_POLL_TIMEOUT);
    switch (status)
    {
    case HAL_OK:
      goto Write_Okay;  // 写入成功, 继续读回校验
    case  HAL_ERROR:
      goto Write_BACK;
    case HAL_BUSY:
      HAL_I2C_DeInit(AT24C02_I2C);
      MX_I2C2_Init();  // 重新初始化
      goto Write_BACK;
    default:
      return status;  // HAL_TIMEOUT
    }
    Write_Okay:

    status = HAL_I2C_Mem_Read(AT24C02_I2C, DevAddress, MemAddress, I2C_MEMADD_SIZE_8BIT, &readData, 1, I2C_TIMEOUT);
    if (status != HAL_OK)
    {
      return status;
    }

    if (readData == *pData)
    {
      return status;
    }
  } while (++retryCount < MAX_RETRIES);
  
  return HAL_ERROR; // 超过最大重试次数仍未成功写入
}


/**
 * @brief  向 AT24C02 连续写入多字节 (逐字节模式)
 * @param  DevAddress  I2C 8-bit 设备地址 (7-bit 地址 0x50 左移 1 位后的值)
 *                     传入头文件宏: AT24C02_ADDRESS_Write (0xA0) 或 AT24C02_ADDRESS_Read (0xA1)
 * @param  MemAddress  起始存储地址 (0x00 ~ 0xFF)
 * @param  pData       待写入数据缓冲区指针
 * @param  Size        写入字节数
 * @retval HAL_StatusTypeDef  HAL_OK / HAL_ERROR / HAL_TIMEOUT 等
 *
 * @note   逐字节写入, 每次只写 1 字节 (未使用 8 字节页写功能)。
 *         单字节的写入校验和重试由 WriteByte() 负责:
 *         ACK 轮询等待写周期 + 读回比对, 最多重试 MAX_RETRIES 次。
 *         任一字节写入失败即返回错误, 后续数据不再继续。
 */
HAL_StatusTypeDef AT24C02_Write(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size)
{
    HAL_StatusTypeDef status = HAL_OK;
    if (Size == 0)
    {
        return HAL_ERROR; // 无数据可写
    }
    else if (Size > EEPROM_Size - MemAddress || MemAddress >= EEPROM_Size)
    {
        return HAL_ERROR; // 超出 AT24C02 存储范围
    }
    while (Size > 0)
    {
        status = AT24C02_WriteByte(DevAddress, MemAddress, pData);
        if (status != HAL_OK)
        {
            return status;
        }
        MemAddress++;
        pData++;
        Size--;
    }
    return status;
}

/**
 * @brief  从 AT24C02 连续读取多字节 (Sequential Read 模式)
 * @param  DevAddress  I2C 8-bit 设备地址 (7-bit 地址 0x50 左移 1 位后的值)
 *                     传入头文件宏: AT24C02_ADDRESS_Write (0xA0) 或 AT24C02_ADDRESS_Read (0xA1)
 * @param  MemAddress  起始存储地址 (0x00 ~ 0xFF)
 * @param  pData       读取数据存放缓冲区指针
 * @param  Size        读取字节数
 * @retval HAL_StatusTypeDef  HAL_OK / HAL_ERROR / HAL_TIMEOUT 等
 *
 * @note   通过 HAL_I2C_Mem_Read 一次性读取 Size 字节。
 *         AT24C02 支持 Sequential Read, 芯片内部地址自动递增,
 *         无需逐字节重发 START 和内存地址。
 */
HAL_StatusTypeDef AT24C02_Read(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size)
{
    if (Size == 0)
    {
        return HAL_ERROR;
    }
    if (Size > EEPROM_Size - MemAddress || MemAddress >= EEPROM_Size)
    {
        return HAL_ERROR;
    }
    return HAL_I2C_Mem_Read(AT24C02_I2C, DevAddress, MemAddress, I2C_MEMADD_SIZE_8BIT, pData, Size, I2C_TIMEOUT);
}
