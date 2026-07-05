#include "EDID.h"

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

