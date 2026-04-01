#ifndef _BSP_I2C_H
#define _BSP_I2C_H

#include "main.h"
#include "i2c.h"

#define RETRY_COUNT 10

HAL_StatusTypeDef HAL_I2C_Write_16Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Read_16Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Write_8Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef HAL_I2C_Read_8Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout);

#endif /* _BSP_I2C_H */
