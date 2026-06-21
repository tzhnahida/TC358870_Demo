/**
 * @file    TC358870.c
 * @brief   TC358870XBG HDMI → MIPI DSI 桥接芯片 I2C 寄存器读写实现
 *
 * TC358870 寄存器地址为 16-bit (big-endian), 故采用 HAL_I2C_Master_Transmit
 * / Master_Receive 手动构造 I2C 帧, 而非 HAL_I2C_Mem_Write (仅支持 8-bit 地址)。
 *
 * 帧格式:
 *   Write: [RegAddr_H, RegAddr_L, Data ...]
 *   Read:  [RegAddr_H, RegAddr_L] → RESTART → [Data ...]
 */

#include "TC358870.h"

#define I2C_TIMEOUT            1000          /**< I2C 读写操作超时 (ms) */
#define MAX_RETRIES            3
#define ACK_POLL_TIMEOUT       5                 /**< ACK 轮询单次超时 (ms), TC358870 写周期 ≤5ms */


/**
 * @brief  写 8-bit 寄存器
 * @param  DevAddress  I2C 8-bit 设备地址 (TC358870_ADDRESS_Write = 0x1E)
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        8-bit 写入值
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 */
HAL_StatusTypeDef TC358870_WriteReg_8Bit(uint16_t DevAddress, uint16_t regAddr, uint8_t data)
{
    uint8_t buffer[3];
    buffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    buffer[1] = regAddr & 0xFF;        // 寄存器地址低字节
    buffer[2] = data;                  // 数据字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, buffer, sizeof(buffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }
    return status;
}


/**
 * @brief  读 8-bit 寄存器
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        读回数据存放指针
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 */
HAL_StatusTypeDef TC358870_ReadReg_8Bit(uint16_t DevAddress, uint16_t regAddr, uint8_t *data)
{
    uint8_t addrBuffer[2];
    addrBuffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    addrBuffer[1] = regAddr & 0xFF;        // 寄存器地址低字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, addrBuffer, sizeof(addrBuffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }

    status = HAL_I2C_Master_Receive(TC358870_I2C, DevAddress, data, 1, I2C_TIMEOUT);
    return status;
}


/**
 * @brief  写 16-bit 寄存器 (big-endian)
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        16-bit 写入值 (高字节在前)
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 */
HAL_StatusTypeDef TC358870_WriteReg_16Bit(uint16_t DevAddress, uint16_t regAddr, uint16_t data)
{
    uint8_t buffer[4];
    buffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    buffer[1] = regAddr & 0xFF;        // 寄存器地址低字节
    buffer[2] = (data >> 8) & 0xFF;    // 数据高字节
    buffer[3] = data & 0xFF;           // 数据低字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, buffer, sizeof(buffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }
    return status;
}


/**
 * @brief  读 16-bit 寄存器 (big-endian)
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        读回数据存放指针 (低 16-bit 有效)
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 */
HAL_StatusTypeDef TC358870_ReadReg_16Bit(uint16_t DevAddress, uint16_t regAddr, uint16_t *data)
{
    uint8_t addrBuffer[2];
    addrBuffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    addrBuffer[1] = regAddr & 0xFF;        // 寄存器地址低字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, addrBuffer, sizeof(addrBuffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }

    uint8_t dataBuffer[2];
    status = HAL_I2C_Master_Receive(TC358870_I2C, DevAddress, dataBuffer, sizeof(dataBuffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }

    *data = (dataBuffer[0] << 8) | dataBuffer[1]; // MSB:LSB → uint16_t
    return status;
}


/**
 * @brief  写 32-bit 寄存器 (big-endian)
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        32-bit 写入值 (高字节在前)
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 *
 * @note   TC358870 实际没有 32-bit 寄存器, 保留为 API 完整性。
 *         如需写入连续两个 16-bit 寄存器, 可连续调用 WriteReg_16Bit。
 */
HAL_StatusTypeDef TC358870_WriteReg_32Bit(uint16_t DevAddress, uint16_t regAddr, uint32_t data)
{
    uint8_t buffer[6];
    buffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    buffer[1] = regAddr & 0xFF;        // 寄存器地址低字节
    buffer[2] = (data >> 24) & 0xFF;   // 数据最高字节
    buffer[3] = (data >> 16) & 0xFF;   // 数据次高字节
    buffer[4] = (data >> 8) & 0xFF;    // 数据次低字节
    buffer[5] = data & 0xFF;           // 数据最低字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, buffer, sizeof(buffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }
    return status;
}


/**
 * @brief  读 32-bit 寄存器 (big-endian)
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        读回数据存放指针
 * @retval HAL_OK / HAL_ERROR / HAL_TIMEOUT
 *
 * @note   同上, TC358870 无 32-bit 寄存器, 保留为 API 完整性。
 */
HAL_StatusTypeDef TC358870_ReadReg_32Bit(uint16_t DevAddress, uint16_t regAddr, uint32_t *data)
{
    uint8_t addrBuffer[2];
    addrBuffer[0] = (regAddr >> 8) & 0xFF; // 寄存器地址高字节
    addrBuffer[1] = regAddr & 0xFF;        // 寄存器地址低字节

    HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(TC358870_I2C, DevAddress, addrBuffer, sizeof(addrBuffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }

    uint8_t dataBuffer[4];
    status = HAL_I2C_Master_Receive(TC358870_I2C, DevAddress, dataBuffer, sizeof(dataBuffer), I2C_TIMEOUT);
    if (status != HAL_OK)
    {
        return status;
    }

    // MSB first → uint32_t
    *data = (uint32_t)dataBuffer[0] << 24
          | (uint32_t)dataBuffer[1] << 16
          | (uint32_t)dataBuffer[2] << 8
          | (uint32_t)dataBuffer[3];
    return status;
}

/**
 * @brief  写寄存器 (统一接口, 带 ACK 轮询 + 读回校验 + 重试)
 *
 * 根据 size 自动选择 8/16/32-bit 写入, 写入后等待芯片就绪,
 * 读回比对校验, 失败自动重试 MAX_RETRIES 次。
 *
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        写入值 (位宽由 size 决定)
 * @param  size        数据宽度: TC358870_Reg_8Bit / 16Bit / 32Bit
 * @retval TC358870_STATUS_SUCCESS       写入且校验成功
 * @retval TC358870_STATUS_INVALID_PARAM  无效的 size 参数
 * @retval TC358870_STATUS_I2C_ERROR      I2C 通信失败或校验超限
 */
TC358870_StatusTypeDef TC358870_WriteReg(uint16_t DevAddress, uint16_t regAddr, uint32_t data, TC358870_Reg_Bit size)
{
    HAL_StatusTypeDef status;
    uint8_t readData8 = 0;
    uint16_t readData16 = 0;
    uint32_t readData32 = 0;
    uint8_t retryCount = 0;
    do
    {
        switch (size)
        {
        case TC358870_Reg_8Bit:
            status = TC358870_WriteReg_8Bit(DevAddress, regAddr, (uint8_t)data);
            break;
        case TC358870_Reg_16Bit:
            status = TC358870_WriteReg_16Bit(DevAddress, regAddr, (uint16_t)data);
            break;
        case TC358870_Reg_32Bit:
            status = TC358870_WriteReg_32Bit(DevAddress, regAddr, data);
            break;
        default:
            return TC358870_STATUS_INVALID_PARAM ;
        }
        if (status != HAL_OK)
        {
        return TC358870_STATUS_I2C_ERROR;
        }

        Write_BACK:
        status = HAL_I2C_IsDeviceReady(TC358870_I2C, DevAddress, 3, ACK_POLL_TIMEOUT);
        switch (status)
        {
        case HAL_OK:
            goto Write_Okay;
        case  HAL_ERROR:
            goto Write_BACK;
        case HAL_BUSY:
            HAL_I2C_DeInit(TC358870_I2C);
            MX_I2C2_Init();  // 重新初始化
            goto Write_BACK;
        default:
            return TC358870_STATUS_I2C_ERROR;  // HAL_TIMEOUT
        }

        Write_Okay:
        switch (size)
        {
        case TC358870_Reg_8Bit:
            status = TC358870_ReadReg_8Bit(DevAddress, regAddr, &readData8);
            break;
        case TC358870_Reg_16Bit:	
            status = TC358870_ReadReg_16Bit(DevAddress, regAddr, &readData16);
            break;
        case TC358870_Reg_32Bit:	
            status = TC358870_ReadReg_32Bit(DevAddress, regAddr, &readData32);
            break;
        default:
            return TC358870_STATUS_INVALID_PARAM ;
        }

        if (status != HAL_OK)
        {
			return TC358870_STATUS_I2C_ERROR;
        }

    switch (size) {
    case TC358870_Reg_8Bit:  
        if (readData8  == (uint8_t)data)  
        {
            return TC358870_STATUS_SUCCESS;
        }
        break;
    case TC358870_Reg_16Bit: 
        if (readData16 == (uint16_t)data) 
        {
            return TC358870_STATUS_SUCCESS;
        }
        break;
    case TC358870_Reg_32Bit:
        if (readData32 == data)
        {
            return TC358870_STATUS_SUCCESS;
        }
        break;   
    }

    } while (++retryCount < MAX_RETRIES);
    return TC358870_STATUS_I2C_ERROR;
}

/**
 * @brief  读寄存器 (统一接口)
 *
 * 根据 size 自动选择 8/16/32-bit 读取, 结果统一存入 uint32_t。
 * 8/16-bit 读取时仅写入 data 的低字节/低半字 (STM32 为 little-endian)。
 *
 * @param  DevAddress  I2C 8-bit 设备地址
 * @param  regAddr     16-bit 寄存器地址
 * @param  data        读回数据存放指针 (uint32_t, 低位有效)
 * @param  size        数据宽度: TC358870_Reg_8Bit / 16Bit / 32Bit
 * @retval TC358870_STATUS_SUCCESS       读取成功
 * @retval TC358870_STATUS_INVALID_PARAM  无效的 size 参数
 * @retval TC358870_STATUS_I2C_ERROR      I2C 通信失败
 */
TC358870_StatusTypeDef TC358870_ReadReg(uint16_t DevAddress, uint16_t regAddr, uint32_t *data, TC358870_Reg_Bit size)
{
    HAL_StatusTypeDef status;
    *data = 0; // 初始化为 0, 以防读取失败时 data 未定义
    switch (size)
    {
    case TC358870_Reg_8Bit:
        status = TC358870_ReadReg_8Bit(DevAddress, regAddr, (uint8_t *)data);
        break;
    case TC358870_Reg_16Bit:
        status = TC358870_ReadReg_16Bit(DevAddress, regAddr, (uint16_t *)data);
        break;
    case TC358870_Reg_32Bit:
        status = TC358870_ReadReg_32Bit(DevAddress, regAddr, data);
        break;
    default:
        return TC358870_STATUS_INVALID_PARAM;
    }

    if (status != HAL_OK)
    {
        return TC358870_STATUS_I2C_ERROR;
    }
    return TC358870_STATUS_SUCCESS;
}

