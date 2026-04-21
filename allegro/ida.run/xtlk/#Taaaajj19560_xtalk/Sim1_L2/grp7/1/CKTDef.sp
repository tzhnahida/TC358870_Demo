*Circuit definition*


.SUBCKT SpeedXP_auto_CAP_NP_C0603_100N_100N_C80_C80 nd_out_2 Power Ground

V_SpeedXP_auto_2_En    nd_en_2    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_HDMI-A_HDMI-001S_HDMI-001S_HDMI-001S_HDMI1 nd_out_1 nd_out_10 nd_out_12 nd_out_3 nd_out_4 nd_out_6 nd_out_7 nd_out_9 Power Ground

V_SpeedXP_auto_1_En    nd_en_1    Ground        0.0
V_SpeedXP_auto_10_En    nd_en_10    Ground        0.0
V_SpeedXP_auto_12_En    nd_en_12    Ground        0.0
V_SpeedXP_auto_3_En    nd_en_3    Ground        0.0
V_SpeedXP_auto_4_En    nd_en_4    Ground        0.0
V_SpeedXP_auto_6_En    nd_en_6    Ground        0.0
V_SpeedXP_auto_7_En    nd_en_7    Ground        0.0
V_SpeedXP_auto_9_En    nd_en_9    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD1_ESD1 nd_out_1 nd_out_10 nd_out_2 nd_out_4 nd_out_5 nd_out_6 nd_out_7 nd_out_9 Power Ground

V_SpeedXP_auto_1_En    nd_en_1    Ground        1.0
X_SpeedXP_auto_1_St     nd_in_1    Ground        SpeedXP_auto_Stimulus_ESD1_HDMI_DATA2_P
V_SpeedXP_auto_10_En    nd_en_10    Ground        0.0
V_SpeedXP_auto_2_En    nd_en_2    Ground        1.0
X_SpeedXP_auto_2_St     nd_in_2    Ground        SpeedXP_auto_Stimulus_ESD1_HDMI_DATA2_N
V_SpeedXP_auto_4_En    nd_en_4    Ground        1.0
X_SpeedXP_auto_4_St     nd_in_4    Ground        SpeedXP_auto_Stimulus_ESD1_HDMI_DATA1_P
V_SpeedXP_auto_5_En    nd_en_5    Ground        1.0
X_SpeedXP_auto_5_St     nd_in_5    Ground        SpeedXP_auto_Stimulus_ESD1_HDMI_DATA1_N
V_SpeedXP_auto_6_En    nd_en_6    Ground        0.0
V_SpeedXP_auto_7_En    nd_en_7    Ground        0.0
V_SpeedXP_auto_9_En    nd_en_9    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD2_ESD2 nd_out_1 nd_out_10 nd_out_2 nd_out_4 nd_out_5 nd_out_6 nd_out_7 nd_out_9 Power Ground

V_SpeedXP_auto_1_En    nd_en_1    Ground        1.0
X_SpeedXP_auto_1_St     nd_in_1    Ground        SpeedXP_auto_Stimulus_ESD2_HDMI_DATA0_P
V_SpeedXP_auto_10_En    nd_en_10    Ground        0.0
V_SpeedXP_auto_2_En    nd_en_2    Ground        1.0
X_SpeedXP_auto_2_St     nd_in_2    Ground        SpeedXP_auto_Stimulus_ESD2_HDMI_DATA0_N
V_SpeedXP_auto_4_En    nd_en_4    Ground        1.0
X_SpeedXP_auto_4_St     nd_in_4    Ground        SpeedXP_auto_Stimulus_ESD2_HDMI_CLK_P
V_SpeedXP_auto_5_En    nd_en_5    Ground        1.0
X_SpeedXP_auto_5_St     nd_in_5    Ground        SpeedXP_auto_Stimulus_ESD2_HDMI_CLK_N
V_SpeedXP_auto_6_En    nd_en_6    Ground        0.0
V_SpeedXP_auto_7_En    nd_en_7    Ground        0.0
V_SpeedXP_auto_9_En    nd_en_9    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_RES_R0603_10K_10K_R24_R24 nd_out_2 Power Ground

V_SpeedXP_auto_2_En    nd_en_2    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_RES_R0603_1K_1K_R25_R25 nd_out_1 Power Ground

V_SpeedXP_auto_1_En    nd_en_1    Ground        1.0
X_SpeedXP_auto_1_St     nd_in_1    Ground        SpeedXP_auto_Stimulus_R25_N2739972

.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_CLK_N 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	1
+ 1.0000000000e-13	1
+ 7.5000000000e-10	1
+ 7.5010000000e-10	0
+ 1.5000000000e-09	0
+ 1.5001000000e-09	0
+ 2.2500000000e-09	0
+ 2.2501000000e-09	0
+ 3.0000000000e-09	0
+ 3.0001000000e-09	0
+ 3.7500000000e-09	0
+ 3.7501000000e-09	0
+ 4.5000000000e-09	0
+ 4.5001000000e-09	0
+ 5.2500000000e-09	0
+ 5.2501000000e-09	0
+ 6.0000000000e-09	0
+ 6.0001000000e-09	0
+ 6.7500000000e-09	0
+ 6.7501000000e-09	0
+ 7.5000000000e-09	0
+ 7.5001000000e-09	0
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_CLK_P 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	0
+ 1.0000000000e-13	0
+ 7.5000000000e-10	0
+ 7.5010000000e-10	1
+ 1.5000000000e-09	1
+ 1.5001000000e-09	1
+ 2.2500000000e-09	1
+ 2.2501000000e-09	1
+ 3.0000000000e-09	1
+ 3.0001000000e-09	1
+ 3.7500000000e-09	1
+ 3.7501000000e-09	1
+ 4.5000000000e-09	1
+ 4.5001000000e-09	1
+ 5.2500000000e-09	1
+ 5.2501000000e-09	1
+ 6.0000000000e-09	1
+ 6.0001000000e-09	1
+ 6.7500000000e-09	1
+ 6.7501000000e-09	1
+ 7.5000000000e-09	1
+ 7.5001000000e-09	1
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA0_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA0_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA1_N 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	1
+ 1.0000000000e-13	1
+ 7.5000000000e-10	1
+ 7.5010000000e-10	0
+ 1.5000000000e-09	0
+ 1.5001000000e-09	0
+ 2.2500000000e-09	0
+ 2.2501000000e-09	0
+ 3.0000000000e-09	0
+ 3.0001000000e-09	0
+ 3.7500000000e-09	0
+ 3.7501000000e-09	0
+ 4.5000000000e-09	0
+ 4.5001000000e-09	0
+ 5.2500000000e-09	0
+ 5.2501000000e-09	0
+ 6.0000000000e-09	0
+ 6.0001000000e-09	0
+ 6.7500000000e-09	0
+ 6.7501000000e-09	0
+ 7.5000000000e-09	0
+ 7.5001000000e-09	0
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA1_P 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	0
+ 1.0000000000e-13	0
+ 7.5000000000e-10	0
+ 7.5010000000e-10	1
+ 1.5000000000e-09	1
+ 1.5001000000e-09	1
+ 2.2500000000e-09	1
+ 2.2501000000e-09	1
+ 3.0000000000e-09	1
+ 3.0001000000e-09	1
+ 3.7500000000e-09	1
+ 3.7501000000e-09	1
+ 4.5000000000e-09	1
+ 4.5001000000e-09	1
+ 5.2500000000e-09	1
+ 5.2501000000e-09	1
+ 6.0000000000e-09	1
+ 6.0001000000e-09	1
+ 6.7500000000e-09	1
+ 6.7501000000e-09	1
+ 7.5000000000e-09	1
+ 7.5001000000e-09	1
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA2_N 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	0
+ 1.0000000000e-13	0
+ 7.5000000000e-10	0
+ 7.5010000000e-10	0
+ 1.5000000000e-09	0
+ 1.5001000000e-09	0
+ R = 1.0000000000e-13	
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA2_P 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	1
+ 1.0000000000e-13	1
+ 7.5000000000e-10	1
+ 7.5010000000e-10	1
+ 1.5000000000e-09	1
+ 1.5001000000e-09	1
+ R = 1.0000000000e-13	
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA3_N 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	1
+ 1.0000000000e-13	1
+ 7.5000000000e-10	1
+ 7.5010000000e-10	0
+ 1.5000000000e-09	0
+ 1.5001000000e-09	0
+ 2.2500000000e-09	0
+ 2.2501000000e-09	0
+ 3.0000000000e-09	0
+ 3.0001000000e-09	0
+ 3.7500000000e-09	0
+ 3.7501000000e-09	0
+ 4.5000000000e-09	0
+ 4.5001000000e-09	0
+ 5.2500000000e-09	0
+ 5.2501000000e-09	0
+ 6.0000000000e-09	0
+ 6.0001000000e-09	0
+ 6.7500000000e-09	0
+ 6.7501000000e-09	0
+ 7.5000000000e-09	0
+ 7.5001000000e-09	0
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA3_P 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	0
+ 1.0000000000e-13	0
+ 7.5000000000e-10	0
+ 7.5010000000e-10	1
+ 1.5000000000e-09	1
+ 1.5001000000e-09	1
+ 2.2500000000e-09	1
+ 2.2501000000e-09	1
+ 3.0000000000e-09	1
+ 3.0001000000e-09	1
+ 3.7500000000e-09	1
+ 3.7501000000e-09	1
+ 4.5000000000e-09	1
+ 4.5001000000e-09	1
+ 5.2500000000e-09	1
+ 5.2501000000e-09	1
+ 6.0000000000e-09	1
+ 6.0001000000e-09	1
+ 6.7500000000e-09	1
+ 6.7501000000e-09	1
+ 7.5000000000e-09	1
+ 7.5001000000e-09	1
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_CLK_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_CLK_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA0_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA0_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA1_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA1_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA2_N 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	1
+ 1.0000000000e-13	1
+ 7.5000000000e-10	1
+ 7.5010000000e-10	0
+ 1.5000000000e-09	0
+ 1.5001000000e-09	0
+ 2.2500000000e-09	0
+ 2.2501000000e-09	0
+ 3.0000000000e-09	0
+ 3.0001000000e-09	0
+ 3.7500000000e-09	0
+ 3.7501000000e-09	0
+ 4.5000000000e-09	0
+ 4.5001000000e-09	0
+ 5.2500000000e-09	0
+ 5.2501000000e-09	0
+ 6.0000000000e-09	0
+ 6.0001000000e-09	0
+ 6.7500000000e-09	0
+ 6.7501000000e-09	0
+ 7.5000000000e-09	0
+ 7.5001000000e-09	0
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA2_P 1 2

v1 1 2
+ PWL(
+ 0.0000000000e+00	0
+ 1.0000000000e-13	0
+ 7.5000000000e-10	0
+ 7.5010000000e-10	1
+ 1.5000000000e-09	1
+ 1.5001000000e-09	1
+ 2.2500000000e-09	1
+ 2.2501000000e-09	1
+ 3.0000000000e-09	1
+ 3.0001000000e-09	1
+ 3.7500000000e-09	1
+ 3.7501000000e-09	1
+ 4.5000000000e-09	1
+ 4.5001000000e-09	1
+ 5.2500000000e-09	1
+ 5.2501000000e-09	1
+ 6.0000000000e-09	1
+ 6.0001000000e-09	1
+ 6.7500000000e-09	1
+ 6.7501000000e-09	1
+ 7.5000000000e-09	1
+ 7.5001000000e-09	1
+ )


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA3_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA3_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD1_HDMI_DATA1_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD1_HDMI_DATA1_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD1_HDMI_DATA2_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD1_HDMI_DATA2_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD2_HDMI_CLK_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD2_HDMI_CLK_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD2_HDMI_DATA0_N 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_ESD2_HDMI_DATA0_P 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_Stimulus_R25_N2739972 1 2

v1 1 2 0


.ENDS

.SUBCKT SpeedXP_auto_SWITCH-2P_SMD4030_1_6N_1_6N_SW1 nd_out_2 Power Ground

V_SpeedXP_auto_2_En    nd_en_2    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_TC358870XBG_1_VFBGA80_(S1+S2+S3+S4)_TC358870XBG(NOK)_TC358870XBG(NOK)_U8 nd_out_A4 nd_out_A5 nd_out_A6 nd_out_A7 nd_out_A8 nd_out_A9 nd_out_B5 nd_out_B6 nd_out_B7 nd_out_B8 nd_out_B9
+ nd_out_C1 nd_out_C2 nd_out_D1 nd_out_D10 nd_out_D2 nd_out_D9 nd_out_E1 nd_out_E10 nd_out_E2 nd_out_E9
+ nd_out_F1 nd_out_F10 nd_out_F2 nd_out_F9 nd_out_G10 nd_out_G9 nd_out_H10 nd_out_H9 nd_out_K8 Power
+ Ground

B_SpeedXP_auto_A6     Power_A6     Ground    nd_out_A6    nd_in_A6    nd_en_A6    Ground    nd_out_of_in_A6     Power_A6     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = A6
+    component = 'U8'

Vpwr_A6  Power_A6  Ground 2.500000e+00
B_SpeedXP_auto_B6     Power_B6     Ground    nd_out_B6    nd_in_B6    nd_en_B6    Ground    nd_out_of_in_B6     Power_B6     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = B6
+    component = 'U8'

Vpwr_B6  Power_B6  Ground 2.500000e+00
B_SpeedXP_auto_D10     Power_D10     Ground    nd_out_D10    nd_in_D10    nd_en_D10    Ground    nd_out_of_in_D10     Power_D10     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = D10
+    component = 'U8'

Vpwr_D10  Power_D10  Ground 2.500000e+00
B_SpeedXP_auto_D9     Power_D9     Ground    nd_out_D9    nd_in_D9    nd_en_D9    Ground    nd_out_of_in_D9     Power_D9     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = D9
+    component = 'U8'

Vpwr_D9  Power_D9  Ground 2.500000e+00
B_SpeedXP_auto_E10     Power_E10     Ground    nd_out_E10    nd_in_E10    nd_en_E10    Ground    nd_out_of_in_E10     Power_E10     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = E10
+    component = 'U8'

Vpwr_E10  Power_E10  Ground 2.500000e+00
B_SpeedXP_auto_E9     Power_E9     Ground    nd_out_E9    nd_in_E9    nd_en_E9    Ground    nd_out_of_in_E9     Power_E9     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = E9
+    component = 'U8'

Vpwr_E9  Power_E9  Ground 2.500000e+00
B_SpeedXP_auto_F10     Power_F10     Ground    nd_out_F10    nd_in_F10    nd_en_F10    Ground    nd_out_of_in_F10     Power_F10     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = F10
+    component = 'U8'

Vpwr_F10  Power_F10  Ground 2.500000e+00
B_SpeedXP_auto_F9     Power_F9     Ground    nd_out_F9    nd_in_F9    nd_en_F9    Ground    nd_out_of_in_F9     Power_F9     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = F9
+    component = 'U8'

Vpwr_F9  Power_F9  Ground 2.500000e+00
B_SpeedXP_auto_G10     Power_G10     Ground    nd_out_G10    nd_in_G10    nd_en_G10    Ground    nd_out_of_in_G10     Power_G10     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = G10
+    component = 'U8'

Vpwr_G10  Power_G10  Ground 2.500000e+00
B_SpeedXP_auto_G9     Power_G9     Ground    nd_out_G9    nd_in_G9    nd_en_G9    Ground    nd_out_of_in_G9     Power_G9     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_u8.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = G9
+    component = 'U8'

Vpwr_G9  Power_G9  Ground 2.500000e+00
V_SpeedXP_auto_A4_En    nd_en_A4    Ground        0.0
V_SpeedXP_auto_A5_En    nd_en_A5    Ground        0.0
V_SpeedXP_auto_A6_En    nd_en_A6    Ground        0.0
V_SpeedXP_auto_A7_En    nd_en_A7    Ground        0.0
V_SpeedXP_auto_A8_En    nd_en_A8    Ground        0.0
V_SpeedXP_auto_A9_En    nd_en_A9    Ground        0.0
V_SpeedXP_auto_B5_En    nd_en_B5    Ground        0.0
V_SpeedXP_auto_B6_En    nd_en_B6    Ground        0.0
V_SpeedXP_auto_B7_En    nd_en_B7    Ground        0.0
V_SpeedXP_auto_B8_En    nd_en_B8    Ground        0.0
V_SpeedXP_auto_B9_En    nd_en_B9    Ground        0.0
V_SpeedXP_auto_C1_En    nd_en_C1    Ground        0.0
V_SpeedXP_auto_C2_En    nd_en_C2    Ground        0.0
V_SpeedXP_auto_D1_En    nd_en_D1    Ground        0.0
V_SpeedXP_auto_D10_En    nd_en_D10    Ground        0.0
V_SpeedXP_auto_D2_En    nd_en_D2    Ground        0.0
V_SpeedXP_auto_D9_En    nd_en_D9    Ground        0.0
V_SpeedXP_auto_E1_En    nd_en_E1    Ground        0.0
V_SpeedXP_auto_E10_En    nd_en_E10    Ground        0.0
V_SpeedXP_auto_E2_En    nd_en_E2    Ground        0.0
V_SpeedXP_auto_E9_En    nd_en_E9    Ground        0.0
V_SpeedXP_auto_F1_En    nd_en_F1    Ground        0.0
V_SpeedXP_auto_F10_En    nd_en_F10    Ground        0.0
V_SpeedXP_auto_F2_En    nd_en_F2    Ground        0.0
V_SpeedXP_auto_F9_En    nd_en_F9    Ground        0.0
V_SpeedXP_auto_G10_En    nd_en_G10    Ground        0.0
V_SpeedXP_auto_G9_En    nd_en_G9    Ground        0.0
V_SpeedXP_auto_H10_En    nd_en_H10    Ground        0.0
V_SpeedXP_auto_H9_En    nd_en_H9    Ground        0.0
V_SpeedXP_auto_K8_En    nd_en_K8    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_TVS/ESD_SOD-323_H3V3HD3U_H3V3HD3U_D5 nd_out_1 Power Ground

V_SpeedXP_auto_1_En    nd_en_1    Ground        0.0

.ENDS

.SUBCKT SpeedXP_auto_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_CH1 nd_out_1 nd_out_10 nd_out_11 nd_out_12 nd_out_13 nd_out_14 nd_out_15 nd_out_16 nd_out_17 nd_out_18 nd_out_19
+ nd_out_2 nd_out_20 nd_out_3 nd_out_4 nd_out_5 nd_out_6 nd_out_7 nd_out_8 nd_out_9 Power
+ Ground

B_SpeedXP_auto_1     Power_1     Ground    nd_out_1    nd_in_1    nd_en_1    Ground    nd_out_of_in_1     Power_1     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 1
+    component = 'CH1'

Vpwr_1  Power_1  Ground 2.500000e+00
B_SpeedXP_auto_10     Power_10     Ground    nd_out_10    nd_in_10    nd_en_10    Ground    nd_out_of_in_10     Power_10     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 10
+    component = 'CH1'

Vpwr_10  Power_10  Ground 2.500000e+00
B_SpeedXP_auto_11     Power_11     Ground    nd_out_11    nd_in_11    nd_en_11    Ground    nd_out_of_in_11     Power_11     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 11
+    component = 'CH1'

Vpwr_11  Power_11  Ground 2.500000e+00
B_SpeedXP_auto_12     Power_12     Ground    nd_out_12    nd_in_12    nd_en_12    Ground    nd_out_of_in_12     Power_12     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 12
+    component = 'CH1'

Vpwr_12  Power_12  Ground 2.500000e+00
B_SpeedXP_auto_2     Power_2     Ground    nd_out_2    nd_in_2    nd_en_2    Ground    nd_out_of_in_2     Power_2     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 2
+    component = 'CH1'

Vpwr_2  Power_2  Ground 2.500000e+00
B_SpeedXP_auto_5     Power_5     Ground    nd_out_5    nd_in_5    nd_en_5    Ground    nd_out_of_in_5     Power_5     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 5
+    component = 'CH1'

Vpwr_5  Power_5  Ground 2.500000e+00
B_SpeedXP_auto_6     Power_6     Ground    nd_out_6    nd_in_6    nd_en_6    Ground    nd_out_of_in_6     Power_6     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 6
+    component = 'CH1'

Vpwr_6  Power_6  Ground 2.500000e+00
B_SpeedXP_auto_7     Power_7     Ground    nd_out_7    nd_in_7    nd_en_7    Ground    nd_out_of_in_7     Power_7     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 7
+    component = 'CH1'

Vpwr_7  Power_7  Ground 2.500000e+00
B_SpeedXP_auto_8     Power_8     Ground    nd_out_8    nd_in_8    nd_en_8    Ground    nd_out_of_in_8     Power_8     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 8
+    component = 'CH1'

Vpwr_8  Power_8  Ground 2.500000e+00
B_SpeedXP_auto_9     Power_9     Ground    nd_out_9    nd_in_9    nd_en_9    Ground    nd_out_of_in_9     Power_9     Ground
+    file = '..\..\..\#taaaajj19560_xtalk_ch1.ibs' model = 'cds_bi_gen_2p5v_10_10pf'
+    Typ = typ
+    buffer = input_output
+    package = yes
+    pin = 9
+    component = 'CH1'

Vpwr_9  Power_9  Ground 2.500000e+00
V_SpeedXP_auto_1_En    nd_en_1    Ground        1.0
X_SpeedXP_auto_1_St     nd_in_1    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA3_N
V_SpeedXP_auto_10_En    nd_en_10    Ground        1.0
X_SpeedXP_auto_10_St     nd_in_10    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA2_P
V_SpeedXP_auto_11_En    nd_en_11    Ground        1.0
X_SpeedXP_auto_11_St     nd_in_11    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA2_P
V_SpeedXP_auto_12_En    nd_en_12    Ground        1.0
X_SpeedXP_auto_12_St     nd_in_12    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA2_N
V_SpeedXP_auto_13_En    nd_en_13    Ground        1.0
X_SpeedXP_auto_13_St     nd_in_13    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA1_P
V_SpeedXP_auto_14_En    nd_en_14    Ground        1.0
X_SpeedXP_auto_14_St     nd_in_14    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA1_N
V_SpeedXP_auto_15_En    nd_en_15    Ground        1.0
X_SpeedXP_auto_15_St     nd_in_15    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_CLK_P
V_SpeedXP_auto_16_En    nd_en_16    Ground        1.0
X_SpeedXP_auto_16_St     nd_in_16    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_CLK_N
V_SpeedXP_auto_17_En    nd_en_17    Ground        1.0
X_SpeedXP_auto_17_St     nd_in_17    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA0_P
V_SpeedXP_auto_18_En    nd_en_18    Ground        1.0
X_SpeedXP_auto_18_St     nd_in_18    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA0_N
V_SpeedXP_auto_19_En    nd_en_19    Ground        1.0
X_SpeedXP_auto_19_St     nd_in_19    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA3_P
V_SpeedXP_auto_2_En    nd_en_2    Ground        1.0
X_SpeedXP_auto_2_St     nd_in_2    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA3_P
V_SpeedXP_auto_20_En    nd_en_20    Ground        1.0
X_SpeedXP_auto_20_St     nd_in_20    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI1_DATA3_N
V_SpeedXP_auto_3_En    nd_en_3    Ground        1.0
X_SpeedXP_auto_3_St     nd_in_3    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA0_N
V_SpeedXP_auto_4_En    nd_en_4    Ground        1.0
X_SpeedXP_auto_4_St     nd_in_4    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA0_P
V_SpeedXP_auto_5_En    nd_en_5    Ground        1.0
X_SpeedXP_auto_5_St     nd_in_5    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_CLK_N
V_SpeedXP_auto_6_En    nd_en_6    Ground        1.0
X_SpeedXP_auto_6_St     nd_in_6    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_CLK_P
V_SpeedXP_auto_7_En    nd_en_7    Ground        1.0
X_SpeedXP_auto_7_St     nd_in_7    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA1_N
V_SpeedXP_auto_8_En    nd_en_8    Ground        1.0
X_SpeedXP_auto_8_St     nd_in_8    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA1_P
V_SpeedXP_auto_9_En    nd_en_9    Ground        1.0
X_SpeedXP_auto_9_St     nd_in_9    Ground        SpeedXP_auto_Stimulus_CH1_MIPI_DSI0_DATA2_N

.ENDS
************** Definition of partial circuits**************


.SUBCKT CAP_NP_C0603_100N_100N_C80 1 2 

X_SpeedXP_auto_CAP_NP_C0603_100N_100N_C80_C80
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         2     POWER     GND
+     SpeedXP_auto_CAP_NP_C0603_100N_100N_C80_C80

.ENDS

.SUBCKT HDMI-A_HDMI-001S_HDMI-001S_HDMI-001S 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 3 4 5 6 
+ 7 8 9 

X_SpeedXP_auto_HDMI-A_HDMI-001S_HDMI-001S_HDMI-001S_HDMI1
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     10     12     3     4     6     7     9     POWER     GND
+     SpeedXP_auto_HDMI-A_HDMI-001S_HDMI-001S_HDMI-001S_HDMI1

.ENDS

.SUBCKT IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD1 1 10 2 3 4 5 6 7 8 9 

X_SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD1_ESD1
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     10     2     4     5     6     7     9     POWER     GND
+     SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD1_ESD1

.ENDS

.SUBCKT IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD2 1 10 2 3 4 5 6 7 8 9 

X_SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD2_ESD2
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     10     2     4     5     6     7     9     POWER     GND
+     SpeedXP_auto_IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD2_ESD2

.ENDS

.SUBCKT RES_R0603_10K_10K_R24 1 2 

X_SpeedXP_auto_RES_R0603_10K_10K_R24_R24
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         2     POWER     GND
+     SpeedXP_auto_RES_R0603_10K_10K_R24_R24

.ENDS

.SUBCKT RES_R0603_1K_1K_R25 1 2 

X_SpeedXP_auto_RES_R0603_1K_1K_R25_R25
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     POWER     GND
+     SpeedXP_auto_RES_R0603_1K_1K_R25_R25

.ENDS

.SUBCKT SWITCH-2P_SMD4030_1_6N_1_6N 1 2 

X_SpeedXP_auto_SWITCH-2P_SMD4030_1_6N_1_6N_SW1
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         2     POWER     GND
+     SpeedXP_auto_SWITCH-2P_SMD4030_1_6N_1_6N_SW1

.ENDS

.SUBCKT TC358870XBG_1_VFBGA80_(S1+S2+S3+S4)_TC358870XBG(NOK)_TC358870XBG(NOK) A1 A10 A2 A3 A4 A5 A6 A7 A8 A9 B1 B10 B2 B3 B4 B5 B6 B7 B8 B9 
+ C1 C10 C2 C9 D1 D10 D2 D4 D5 D6 D7 D9 E1 E10 E2 E4 E5 E6 E7 E9 
+ F1 F10 F2 F4 F5 F6 F7 F9 G1 G10 G2 G4 G5 G6 G7 G9 H1 H10 H2 H9 
+ J1 J10 J2 J3 J4 J5 J6 J7 J8 J9 K1 K10 K2 K3 K4 K5 K6 K7 K8 K9 
+ 

X_SpeedXP_auto_TC358870XBG_1_VFBGA80_(S1+S2+S3+S4)_TC358870XBG(NOK)_TC358870XBG(NOK)_U8
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         A4     A5     A6     A7     A8     A9     B5     B6     B7     B8     B9
+          C1     C2     D1     D10     D2     D9     E1     E10     E2     E9     F1
+          F10     F2     F9     G10     G9     H10     H9     K8     POWER     GND
+     SpeedXP_auto_TC358870XBG_1_VFBGA80_(S1+S2+S3+S4)_TC358870XBG(NOK)_TC358870XBG(NOK)_U8

.ENDS

.SUBCKT TVS/ESD_SOD-323_H3V3HD3U_H3V3HD3U 1 2 

X_SpeedXP_auto_TVS/ESD_SOD-323_H3V3HD3U_H3V3HD3U_D5
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     POWER     GND
+     SpeedXP_auto_TVS/ESD_SOD-323_H3V3HD3U_H3V3HD3U_D5

.ENDS

.SUBCKT WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 
+ 28 29 3 30 31 32 33 34 35 36 37 38 39 4 40 5 6 7 8 9 
+ P1 P2 P3 P4 

X_SpeedXP_auto_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_CH1
*  NOTE - the SpeedXP generated subcircuit call for IBIS buffers
*       DO NOT edit the rest of this line to prevent incorrect node-to-pin mapping.
*       Package = NO
*       Series Pin Mapping : 
*       End Series Pin Mapping
*       Pin Mapping : Sequential.
+         1     10     11     12     13     14     15     16     17     18     19
+          2     20     3     4     5     6     7     8     9     POWER     GND
+     SpeedXP_auto_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_CH1

.ENDS

************** Interfaces between components and partial circuits**************

.SUBCKT C80~ 1 2 
Xpartial 1 2 CAP_NP_C0603_100N_100N_C80
.ENDS

.SUBCKT CH1~ 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 28 
+ 29 3 30 31 32 33 34 35 36 37 38 39 4 40 5 6 7 8 9 P1 
+ P2 P3 P4 
Xpartial 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 24 25 26 27 
+ 28 29 3 30 31 32 33 34 35 36 37 38 39 4 40 5 6 7 8 9 
+ P1 P2 P3 P4 WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000_WP7B-P040VA1-R8000
.Print v(Xpartial.1 0)
.Print v(Xpartial.10 0)
.Print v(Xpartial.11 0)
.Print v(Xpartial.12 0)
.Print v(Xpartial.2 0)
.Print v(Xpartial.5 0)
.Print v(Xpartial.6 0)
.Print v(Xpartial.7 0)
.Print v(Xpartial.8 0)
.Print v(Xpartial.9 0)
.Print v(Xpartial.2 Xpartial.1)
.Print v(Xpartial.10 Xpartial.9)
.Print v(Xpartial.11 Xpartial.12)
.Print v(Xpartial.6 Xpartial.5)
.Print v(Xpartial.8 Xpartial.7)
.ENDS

.SUBCKT D5~ 1 2 
Xpartial 1 2 TVS/ESD_SOD-323_H3V3HD3U_H3V3HD3U
.ENDS

.SUBCKT ESD1~ 1 10 2 3 4 5 6 7 8 9 
Xpartial 1 10 2 3 4 5 6 7 8 9 IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD1
.ENDS

.SUBCKT ESD2~ 1 10 2 3 4 5 6 7 8 9 
Xpartial 1 10 2 3 4 5 6 7 8 9 IP4292CZ10_DFN2510A-10_IP4292CZ10-TBR_115_IP4292CZ10-TBR_115_ESD2
.ENDS

.SUBCKT HDMI1~ 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 3 4 5 6 7 
+ 8 9 
Xpartial 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 23 3 4 5 6 
+ 7 8 9 HDMI-A_HDMI-001S_HDMI-001S_HDMI-001S
.ENDS

.SUBCKT R24~ 1 2 
Xpartial 1 2 RES_R0603_10K_10K_R24
.ENDS

.SUBCKT R25~ 1 2 
Xpartial 1 2 RES_R0603_1K_1K_R25
.ENDS

.SUBCKT SW1~ 1 2 
Xpartial 1 2 SWITCH-2P_SMD4030_1_6N_1_6N
.ENDS

.SUBCKT U8~ A1 A10 A2 A3 A4 A5 A6 A7 A8 A9 B1 B10 B2 B3 B4 B5 B6 B7 B8 B9 C1 
+ C10 C2 C9 D1 D10 D2 D4 D5 D6 D7 D9 E1 E10 E2 E4 E5 E6 E7 E9 F1 
+ F10 F2 F4 F5 F6 F7 F9 G1 G10 G2 G4 G5 G6 G7 G9 H1 H10 H2 H9 J1 
+ J10 J2 J3 J4 J5 J6 J7 J8 J9 K1 K10 K2 K3 K4 K5 K6 K7 K8 K9 
Xpartial A1 A10 A2 A3 A4 A5 A6 A7 A8 A9 B1 B10 B2 B3 B4 B5 B6 B7 B8 B9 
+ C1 C10 C2 C9 D1 D10 D2 D4 D5 D6 D7 D9 E1 E10 E2 E4 E5 E6 E7 E9 
+ F1 F10 F2 F4 F5 F6 F7 F9 G1 G10 G2 G4 G5 G6 G7 G9 H1 H10 H2 H9 
+ J1 J10 J2 J3 J4 J5 J6 J7 J8 J9 K1 K10 K2 K3 K4 K5 K6 K7 K8 K9 
+ TC358870XBG_1_VFBGA80_(S1+S2+S3+S4)_TC358870XBG(NOK)_TC358870XBG(NOK)
.Print v(Xpartial.A6 0)
.Print v(Xpartial.B6 0)
.Print v(Xpartial.D10 0)
.Print v(Xpartial.D9 0)
.Print v(Xpartial.E10 0)
.Print v(Xpartial.E9 0)
.Print v(Xpartial.F10 0)
.Print v(Xpartial.F9 0)
.Print v(Xpartial.G10 0)
.Print v(Xpartial.G9 0)
.Print v(Xpartial.A6 Xpartial.B6)
.Print v(Xpartial.D10 Xpartial.D9)
.Print v(Xpartial.E10 Xpartial.E9)
.Print v(Xpartial.F10 Xpartial.F9)
.Print v(Xpartial.G10 Xpartial.G9)
.ENDS
