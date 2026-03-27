#ifndef _TC358870_H_
#define _TC358870_H_
#include "main.h"
#include "bsp_i2c.h"

#define TC358870_ADDR (0x0F << 1)

#define REG_BIT(n) (1U << (n))


typedef enum
{
    TC358870_OK = 0,
    TC358870_ERROR,
    TC358870_NOT_READY,
    TC358870_BUSY,
    TC358870_TIMEOUT,

    TC358870_I2C_NACK,
    TC358870_NO_CABLE,
    
    TC358870_PLL_UNLOCKED,
    TC358870_NO_VIDEO,
    TC358870_HDCP_FAIL,
    
    TC358870_EDID_INVALID,
    TC358870_DSI_CONFIG_ERROR,
    
} TC358870_Status_t;

typedef enum
{
    /* --- 5.11 HDMI Rx System Control (0x8410 - 0x854A) --- */
    REG_PHY_CTL             = 0x8410, // PHY 控制
    REG_PHY_ENB             = 0x8413, // PHY 使能
    REG_PHY_RSTX            = 0x8414, // PHY 复位
    REG_DDCIO_CTL           = 0x84F4, // DDC IO 控制
    
    REG_HDMI_INT0           = 0x8500, // 中断寄存器 0
    REG_HDMI_INT1           = 0x8501, // 中断寄存器 1
    REG_SYS_INT             = 0x8502, // 系统中断
    
    REG_SYS_STATUS          = 0x8520, // 系统状态 (5V 检测, TMDS 锁定)
    REG_VI_STATUS           = 0x8521, // 视频输入状态 (Deep Color, 格式)
    REG_CLK_STATUS          = 0x8526, // 时钟锁定状态
    
    REG_DDC_CTL             = 0x8543, // DDC 总线控制
    REG_HPD_CTL             = 0x8544, // HPD 强制控制 (关键！)
    REG_INIT_END            = 0x854A, // 初始化结束标志 (写入 0x01 释放 HPD)

    /* --- 5.11.61 EDID Configuration (0x85E0 - 0x85E5) --- */
    REG_EDID_MODE           = 0x85E0, // EDID 模式 (0x01: 内部 RAM)
    REG_EDID_LEN1           = 0x85E3, // EDID 长度低字节 (128 = 0x80)
    REG_EDID_LEN2           = 0x85E4, // EDID 长度高字节
    
    /* --- 5.13 HDMI Rx InfoFrame (0x8700+) --- */
    REG_CLR_INFO            = 0x8700, // 清除 InfoFrame
    REG_AVI_INFO_BASE       = 0x8710, // AVI InfoFrame 数据起始地址

    /* --- EDID SRAM Area (Memory Map) --- */
    REG_EDID_SRAM_BASE      = 0x8C00, // 1KB EDID SRAM 的起始地址
    REG_EDID_SRAM_END       = 0x8FFF, // EDID SRAM 结束

    /* --- DSI TX Control (0x0000 - 0x05FF / 0x5000+) --- */
    REG_DSI_LANE_CONFIG     = 0x0100, // DSI Lane 数量配置
    REG_DSI_START           = 0x0518, // DSI 传输开始触发
    REG_LINE_SPLIT_CTL      = 0x5000, // 分屏控制 (Dual Link 模式)

    REG_CHIP_ID      = 0x0000, // Chip ID 寄存器

} TC358870_Reg_t;





HAL_StatusTypeDef TC358870_Write_Safe(uint16_t reg, uint8_t data, uint8_t mask);
HAL_StatusTypeDef TC358870_Write(uint16_t reg, uint8_t data,uint16_t Size, uint32_t Timeout);
HAL_StatusTypeDef TC358870_Read(uint16_t reg, uint8_t *data,uint16_t Size, uint32_t Timeout);
TC358870_Status_t TC358870_Identify(void);

#endif /* _TC358870_H_ */
