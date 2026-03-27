#include "bsp_i2c.h"


HAL_StatusTypeDef HAL_I2C_Write_16Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
{
  HAL_StatusTypeDef hal_status;
  uint32_t retry_count = 0;
  do
  {
    hal_status = HAL_I2C_Mem_Write(&hi2c2, DevAddress, MemAddress, I2C_MEMADD_SIZE_16BIT, pData, Size, Timeout);
    HAL_Delay(5);
    if (retry_count == RETRY_COUNT)
      return hal_status;
    if (hal_status == HAL_BUSY)
    {
        HAL_I2C_DeInit(&hi2c2);
        MX_I2C2_Init();
    }
    
    retry_count++;
  } while (hal_status != HAL_OK && hal_status != HAL_TIMEOUT);
  return hal_status;
}

HAL_StatusTypeDef HAL_I2C_Read_16Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
{
  HAL_StatusTypeDef hal_status;
  uint32_t retry_count = 0;
  do
  {
    hal_status = HAL_I2C_Mem_Read(&hi2c2, DevAddress, MemAddress, I2C_MEMADD_SIZE_16BIT, pData, Size, Timeout);
    HAL_Delay(5);
    if (retry_count == RETRY_COUNT)
      return hal_status;
    if (hal_status == HAL_BUSY)
    {
        HAL_I2C_DeInit(&hi2c2);
        MX_I2C2_Init();
    }
    retry_count++;
  } while (hal_status != HAL_OK && hal_status != HAL_TIMEOUT);
  return hal_status;
}

HAL_StatusTypeDef HAL_I2C_Write_8Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
{
  HAL_StatusTypeDef hal_status;
  uint32_t retry_count = 0;
  do
  {
    hal_status = HAL_I2C_Mem_Write(&hi2c2, DevAddress, MemAddress, I2C_MEMADD_SIZE_8BIT, pData, Size, Timeout);
    HAL_Delay(5);
    if (retry_count == RETRY_COUNT)
      return hal_status;
    if (hal_status == HAL_BUSY)
    {
        HAL_I2C_DeInit(&hi2c2);
        MX_I2C2_Init();
    }
    retry_count++;
  } while (hal_status != HAL_OK && hal_status != HAL_TIMEOUT);
  return hal_status;
}

HAL_StatusTypeDef HAL_I2C_Read_8Bit(uint16_t DevAddress, uint16_t MemAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
{
  HAL_StatusTypeDef hal_status;
  uint32_t retry_count = 0;
  do
  {
    hal_status = HAL_I2C_Mem_Read(&hi2c2, DevAddress, MemAddress, I2C_MEMADD_SIZE_8BIT, pData, Size, Timeout);
    HAL_Delay(5);
    if (retry_count == RETRY_COUNT)
      return hal_status;
    if (hal_status == HAL_BUSY)
    {
        HAL_I2C_DeInit(&hi2c2);
        MX_I2C2_Init();
    }
    retry_count++;
  } while (hal_status != HAL_OK && hal_status != HAL_TIMEOUT);
  return hal_status;
}
