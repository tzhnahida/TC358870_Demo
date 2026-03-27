#include "tc358870.h"

HAL_StatusTypeDef TC358870_Write_Safe(uint16_t reg, uint8_t data, uint8_t mask)
{
    uint8_t current_value;
    if (HAL_I2C_Read_16Bit(TC358870_ADDR, reg, &current_value, 1, 100) != HAL_OK)
        return HAL_ERROR;
    current_value = (current_value & ~mask) | (data & mask);
    return HAL_I2C_Write_16Bit(TC358870_ADDR, reg, &current_value, 1, 100);
}

HAL_StatusTypeDef TC358870_Write(uint16_t reg, uint8_t data,uint16_t Size, uint32_t Timeout)
{
    return HAL_I2C_Write_16Bit(TC358870_ADDR, reg, &data, Size, Timeout);
}

HAL_StatusTypeDef TC358870_Read(uint16_t reg, uint8_t *data,uint16_t Size, uint32_t Timeout)
{
    return HAL_I2C_Read_16Bit(TC358870_ADDR, reg, data, Size, Timeout);
}

TC358870_Status_t TC358870_Identify(void)
{
    uint8_t id_raw[2];
    uint16_t full_id;

    if (TC358870_Read(REG_CHIP_ID, id_raw, 2, 100) != HAL_OK)
        return TC358870_ERROR;

    full_id = (id_raw[0] << 8) | id_raw[1];
    if (full_id== 0x47)
        return TC358870_OK;
    return TC358870_ERROR;
}




