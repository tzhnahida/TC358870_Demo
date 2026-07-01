################################################################################
# 
# This work may not be copied, modified, re-published, uploaded,
# executed, or distributed in any way, in any medium, whether in
# whole or in part, without prior written permission from Cadence
# Design Systems, Inc.
#
# Design: #Taaaafo15224
# Created: Mon Jun 29 18:58:52 2026
################################################################################

# Set working directory
set CurrentPath [sigrity::debug TCLFolderPath {1} {!}]

# Set translator log file name
set CaseTrLogFileName "#Taaaafo15224_qf_tr.log"

# Open allegro design file
sigrity::open document $CaseTrLogFileName {!}
sigrity::update option -mode {extraction} {!}

# Set design unit
sigrity::update option -GlobalUnit {mil} {!}

# Set nets that need to be simulated
sigrity::update net selected 1 -all {!}

# Set ports
sigrity::add port -name {PORT_1} -type {0} -circuit {U9} -posPins {A3} -negPins {D4} {!}
sigrity::add circuit {R1@@PORT_HDMI1_15_17} -def {R1@@PORT_HDMI1_15_17_MODEL} -refCircuit {HDMI1} -refPin {15,17} {!}
sigrity::update cktdef {R1@@PORT_HDMI1_15_17_MODEL} -head {ExtNode = 15 17} -Definition {Rport 15 17 1.0e-6} -check {!}
sigrity::update circuit {R1@@PORT_HDMI1_15_17} -manual {enable} {!}
sigrity::add port -name {PORT_2} -type {0} -circuit {U9} -posPins {B3} -negPins {D4} {!}
sigrity::add circuit {R2@@PORT_HDMI1_16_17} -def {R2@@PORT_HDMI1_16_17_MODEL} -refCircuit {HDMI1} -refPin {16,17} {!}
sigrity::update cktdef {R2@@PORT_HDMI1_16_17_MODEL} -head {ExtNode = 16 17} -Definition {Rport 16 17 1.0e-6} -check {!}
sigrity::update circuit {R2@@PORT_HDMI1_16_17} -manual {enable} {!}
sigrity::add port -name {PORT_3} -type {0} -circuit {U9} -posPins {F1} -negPins {H1} {!}
sigrity::add circuit {R3@@PORT_HDMI1_1_2} -def {R3@@PORT_HDMI1_1_2_MODEL} -refCircuit {HDMI1} -refPin {1,2} {!}
sigrity::update cktdef {R3@@PORT_HDMI1_1_2_MODEL} -head {ExtNode = 1 2} -Definition {Rport 1 2 1.0e-6} -check {!}
sigrity::update circuit {R3@@PORT_HDMI1_1_2} -manual {enable} {!}
sigrity::add port -name {PORT_4} -type {0} -circuit {U9} -posPins {F2} -negPins {F4} {!}
sigrity::add circuit {R4@@PORT_HDMI1_3_2} -def {R4@@PORT_HDMI1_3_2_MODEL} -refCircuit {HDMI1} -refPin {3,2} {!}
sigrity::update cktdef {R4@@PORT_HDMI1_3_2_MODEL} -head {ExtNode = 3 2} -Definition {Rport 3 2 1.0e-6} -check {!}
sigrity::update circuit {R4@@PORT_HDMI1_3_2} -manual {enable} {!}
sigrity::add port -name {PORT_5} -type {0} -circuit {U9} -posPins {C1} -negPins {D4} {!}
sigrity::add circuit {R5@@PORT_HDMI1_10_11} -def {R5@@PORT_HDMI1_10_11_MODEL} -refCircuit {HDMI1} -refPin {10,11} {!}
sigrity::update cktdef {R5@@PORT_HDMI1_10_11_MODEL} -head {ExtNode = 10 11} -Definition {Rport 10 11 1.0e-6} -check {!}
sigrity::update circuit {R5@@PORT_HDMI1_10_11} -manual {enable} {!}
sigrity::add port -name {PORT_6} -type {0} -circuit {U9} -posPins {C2} -negPins {D4} {!}
sigrity::add circuit {R6@@PORT_HDMI1_12_11} -def {R6@@PORT_HDMI1_12_11_MODEL} -refCircuit {HDMI1} -refPin {12,11} {!}
sigrity::update cktdef {R6@@PORT_HDMI1_12_11_MODEL} -head {ExtNode = 12 11} -Definition {Rport 12 11 1.0e-6} -check {!}
sigrity::update circuit {R6@@PORT_HDMI1_12_11} -manual {enable} {!}
sigrity::add port -name {PORT_7} -type {0} -circuit {U9} -posPins {E1} -negPins {H1} {!}
sigrity::add circuit {R7@@PORT_HDMI1_4_5} -def {R7@@PORT_HDMI1_4_5_MODEL} -refCircuit {HDMI1} -refPin {4,5} {!}
sigrity::update cktdef {R7@@PORT_HDMI1_4_5_MODEL} -head {ExtNode = 4 5} -Definition {Rport 4 5 1.0e-6} -check {!}
sigrity::update circuit {R7@@PORT_HDMI1_4_5} -manual {enable} {!}
sigrity::add port -name {PORT_8} -type {0} -circuit {U9} -posPins {E2} -negPins {E4} {!}
sigrity::add circuit {R8@@PORT_HDMI1_6_5} -def {R8@@PORT_HDMI1_6_5_MODEL} -refCircuit {HDMI1} -refPin {6,5} {!}
sigrity::update cktdef {R8@@PORT_HDMI1_6_5_MODEL} -head {ExtNode = 6 5} -Definition {Rport 6 5 1.0e-6} -check {!}
sigrity::update circuit {R8@@PORT_HDMI1_6_5} -manual {enable} {!}
sigrity::add port -name {PORT_9} -type {0} -circuit {U9} -posPins {D1} -negPins {D4} {!}
sigrity::add circuit {R9@@PORT_HDMI1_7_8} -def {R9@@PORT_HDMI1_7_8_MODEL} -refCircuit {HDMI1} -refPin {7,8} {!}
sigrity::update cktdef {R9@@PORT_HDMI1_7_8_MODEL} -head {ExtNode = 7 8} -Definition {Rport 7 8 1.0e-6} -check {!}
sigrity::update circuit {R9@@PORT_HDMI1_7_8} -manual {enable} {!}
sigrity::add port -name {PORT_10} -type {0} -circuit {U9} -posPins {D2} -negPins {D4} {!}
sigrity::add circuit {R10@@PORT_HDMI1_9_8} -def {R10@@PORT_HDMI1_9_8_MODEL} -refCircuit {HDMI1} -refPin {9,8} {!}
sigrity::update cktdef {R10@@PORT_HDMI1_9_8_MODEL} -head {ExtNode = 9 8} -Definition {Rport 9 8 1.0e-6} -check {!}
sigrity::update circuit {R10@@PORT_HDMI1_9_8} -manual {enable} {!}
sigrity::add port -name {PORT_11} -type {0} -circuit {CH2} -posPins {19} -negPins {21} {!}
sigrity::add circuit {R11@@PORT_U9_A5_D5} -def {R11@@PORT_U9_A5_D5_MODEL} -refCircuit {U9} -refPin {A5,D5} {!}
sigrity::update cktdef {R11@@PORT_U9_A5_D5_MODEL} -head {ExtNode = A5 D5} -Definition {Rport A5 D5 1.0e-6} -check {!}
sigrity::update circuit {R11@@PORT_U9_A5_D5} -manual {enable} {!}
sigrity::add port -name {PORT_12} -type {0} -circuit {CH2} -posPins {20} -negPins {21} {!}
sigrity::add circuit {R12@@PORT_U9_B5_D5} -def {R12@@PORT_U9_B5_D5_MODEL} -refCircuit {U9} -refPin {B5,D5} {!}
sigrity::update cktdef {R12@@PORT_U9_B5_D5_MODEL} -head {ExtNode = B5 D5} -Definition {Rport B5 D5 1.0e-6} -check {!}
sigrity::update circuit {R12@@PORT_U9_B5_D5} -manual {enable} {!}
sigrity::add port -name {PORT_13} -type {0} -circuit {CH2} -posPins {11} -negPins {28} {!}
sigrity::add circuit {R13@@PORT_U9_A6_D6} -def {R13@@PORT_U9_A6_D6_MODEL} -refCircuit {U9} -refPin {A6,D6} {!}
sigrity::update cktdef {R13@@PORT_U9_A6_D6_MODEL} -head {ExtNode = A6 D6} -Definition {Rport A6 D6 1.0e-6} -check {!}
sigrity::update circuit {R13@@PORT_U9_A6_D6} -manual {enable} {!}
sigrity::add port -name {PORT_14} -type {0} -circuit {CH2} -posPins {12} -negPins {28} {!}
sigrity::add circuit {R14@@PORT_U9_B6_D6} -def {R14@@PORT_U9_B6_D6_MODEL} -refCircuit {U9} -refPin {B6,D6} {!}
sigrity::update cktdef {R14@@PORT_U9_B6_D6_MODEL} -head {ExtNode = B6 D6} -Definition {Rport B6 D6 1.0e-6} -check {!}
sigrity::update circuit {R14@@PORT_U9_B6_D6} -manual {enable} {!}
sigrity::add port -name {PORT_15} -type {0} -circuit {CH2} -posPins {15} -negPins {26} {!}
sigrity::add circuit {R15@@PORT_U9_A7_C9} -def {R15@@PORT_U9_A7_C9_MODEL} -refCircuit {U9} -refPin {A7,C9} {!}
sigrity::update cktdef {R15@@PORT_U9_A7_C9_MODEL} -head {ExtNode = A7 C9} -Definition {Rport A7 C9 1.0e-6} -check {!}
sigrity::update circuit {R15@@PORT_U9_A7_C9} -manual {enable} {!}
sigrity::add port -name {PORT_16} -type {0} -circuit {CH2} -posPins {16} -negPins {25} {!}
sigrity::add circuit {R16@@PORT_U9_B7_D7} -def {R16@@PORT_U9_B7_D7_MODEL} -refCircuit {U9} -refPin {B7,D7} {!}
sigrity::update cktdef {R16@@PORT_U9_B7_D7_MODEL} -head {ExtNode = B7 D7} -Definition {Rport B7 D7 1.0e-6} -check {!}
sigrity::update circuit {R16@@PORT_U9_B7_D7} -manual {enable} {!}
sigrity::add port -name {PORT_17} -type {0} -circuit {CH2} -posPins {13} -negPins {28} {!}
sigrity::add circuit {R17@@PORT_U9_A8_A10} -def {R17@@PORT_U9_A8_A10_MODEL} -refCircuit {U9} -refPin {A8,A10} {!}
sigrity::update cktdef {R17@@PORT_U9_A8_A10_MODEL} -head {ExtNode = A8 A10} -Definition {Rport A8 A10 1.0e-6} -check {!}
sigrity::update circuit {R17@@PORT_U9_A8_A10} -manual {enable} {!}
sigrity::add port -name {PORT_18} -type {0} -circuit {CH2} -posPins {14} -negPins {27} {!}
sigrity::add circuit {R18@@PORT_U9_B8_C9} -def {R18@@PORT_U9_B8_C9_MODEL} -refCircuit {U9} -refPin {B8,C9} {!}
sigrity::update cktdef {R18@@PORT_U9_B8_C9_MODEL} -head {ExtNode = B8 C9} -Definition {Rport B8 C9 1.0e-6} -check {!}
sigrity::update circuit {R18@@PORT_U9_B8_C9} -manual {enable} {!}
sigrity::add port -name {PORT_19} -type {0} -circuit {CH2} -posPins {17} -negPins {25} {!}
sigrity::add circuit {R19@@PORT_U9_A9_A10} -def {R19@@PORT_U9_A9_A10_MODEL} -refCircuit {U9} -refPin {A9,A10} {!}
sigrity::update cktdef {R19@@PORT_U9_A9_A10_MODEL} -head {ExtNode = A9 A10} -Definition {Rport A9 A10 1.0e-6} -check {!}
sigrity::update circuit {R19@@PORT_U9_A9_A10} -manual {enable} {!}
sigrity::add port -name {PORT_20} -type {0} -circuit {CH2} -posPins {18} -negPins {21} {!}
sigrity::add circuit {R20@@PORT_U9_B9_C9} -def {R20@@PORT_U9_B9_C9_MODEL} -refCircuit {U9} -refPin {B9,C9} {!}
sigrity::update cktdef {R20@@PORT_U9_B9_C9_MODEL} -head {ExtNode = B9 C9} -Definition {Rport B9 C9 1.0e-6} -check {!}
sigrity::update circuit {R20@@PORT_U9_B9_C9} -manual {enable} {!}
sigrity::add port -name {PORT_21} -type {0} -circuit {CH2} -posPins {2} -negPins {35} {!}
sigrity::add circuit {R21@@PORT_U9_D10_C9} -def {R21@@PORT_U9_D10_C9_MODEL} -refCircuit {U9} -refPin {D10,C9} {!}
sigrity::update cktdef {R21@@PORT_U9_D10_C9_MODEL} -head {ExtNode = D10 C9} -Definition {Rport D10 C9 1.0e-6} -check {!}
sigrity::update circuit {R21@@PORT_U9_D10_C9} -manual {enable} {!}
sigrity::add port -name {PORT_22} -type {0} -circuit {CH2} -posPins {1} -negPins {35} {!}
sigrity::add circuit {R22@@PORT_U9_D9_C9} -def {R22@@PORT_U9_D9_C9_MODEL} -refCircuit {U9} -refPin {D9,C9} {!}
sigrity::update cktdef {R22@@PORT_U9_D9_C9_MODEL} -head {ExtNode = D9 C9} -Definition {Rport D9 C9 1.0e-6} -check {!}
sigrity::update circuit {R22@@PORT_U9_D9_C9} -manual {enable} {!}
sigrity::add port -name {PORT_23} -type {0} -circuit {CH2} -posPins {10} -negPins {33} {!}
sigrity::add circuit {R23@@PORT_U9_E10_C9} -def {R23@@PORT_U9_E10_C9_MODEL} -refCircuit {U9} -refPin {E10,C9} {!}
sigrity::update cktdef {R23@@PORT_U9_E10_C9_MODEL} -head {ExtNode = E10 C9} -Definition {Rport E10 C9 1.0e-6} -check {!}
sigrity::update circuit {R23@@PORT_U9_E10_C9} -manual {enable} {!}
sigrity::add port -name {PORT_24} -type {0} -circuit {CH2} -posPins {9} -negPins {33} {!}
sigrity::add circuit {R24@@PORT_U9_E9_E7} -def {R24@@PORT_U9_E9_E7_MODEL} -refCircuit {U9} -refPin {E9,E7} {!}
sigrity::update cktdef {R24@@PORT_U9_E9_E7_MODEL} -head {ExtNode = E9 E7} -Definition {Rport E9 E7 1.0e-6} -check {!}
sigrity::update circuit {R24@@PORT_U9_E9_E7} -manual {enable} {!}
sigrity::add port -name {PORT_25} -type {0} -circuit {CH2} -posPins {6} -negPins {35} {!}
sigrity::add circuit {R25@@PORT_U9_F10_F7} -def {R25@@PORT_U9_F10_F7_MODEL} -refCircuit {U9} -refPin {F10,F7} {!}
sigrity::update cktdef {R25@@PORT_U9_F10_F7_MODEL} -head {ExtNode = F10 F7} -Definition {Rport F10 F7 1.0e-6} -check {!}
sigrity::update circuit {R25@@PORT_U9_F10_F7} -manual {enable} {!}
sigrity::add port -name {PORT_26} -type {0} -circuit {CH2} -posPins {5} -negPins {35} {!}
sigrity::add circuit {R26@@PORT_U9_F9_F7} -def {R26@@PORT_U9_F9_F7_MODEL} -refCircuit {U9} -refPin {F9,F7} {!}
sigrity::update cktdef {R26@@PORT_U9_F9_F7_MODEL} -head {ExtNode = F9 F7} -Definition {Rport F9 F7 1.0e-6} -check {!}
sigrity::update circuit {R26@@PORT_U9_F9_F7} -manual {enable} {!}
sigrity::add port -name {PORT_27} -type {0} -circuit {CH2} -posPins {8} -negPins {33} {!}
sigrity::add circuit {R27@@PORT_U9_G10_G7} -def {R27@@PORT_U9_G10_G7_MODEL} -refCircuit {U9} -refPin {G10,G7} {!}
sigrity::update cktdef {R27@@PORT_U9_G10_G7_MODEL} -head {ExtNode = G10 G7} -Definition {Rport G10 G7 1.0e-6} -check {!}
sigrity::update circuit {R27@@PORT_U9_G10_G7} -manual {enable} {!}
sigrity::add port -name {PORT_28} -type {0} -circuit {CH2} -posPins {7} -negPins {34} {!}
sigrity::add circuit {R28@@PORT_U9_G9_G7} -def {R28@@PORT_U9_G9_G7_MODEL} -refCircuit {U9} -refPin {G9,G7} {!}
sigrity::update cktdef {R28@@PORT_U9_G9_G7_MODEL} -head {ExtNode = G9 G7} -Definition {Rport G9 G7 1.0e-6} -check {!}
sigrity::update circuit {R28@@PORT_U9_G9_G7} -manual {enable} {!}
sigrity::add port -name {PORT_29} -type {0} -circuit {CH2} -posPins {4} -negPins {35} {!}
sigrity::add circuit {R29@@PORT_U9_H10_K10} -def {R29@@PORT_U9_H10_K10_MODEL} -refCircuit {U9} -refPin {H10,K10} {!}
sigrity::update cktdef {R29@@PORT_U9_H10_K10_MODEL} -head {ExtNode = H10 K10} -Definition {Rport H10 K10 1.0e-6} -check {!}
sigrity::update circuit {R29@@PORT_U9_H10_K10} -manual {enable} {!}
sigrity::add port -name {PORT_30} -type {0} -circuit {CH2} -posPins {3} -negPins {35} {!}
sigrity::add circuit {R30@@PORT_U9_H9_G7} -def {R30@@PORT_U9_H9_G7_MODEL} -refCircuit {U9} -refPin {H9,G7} {!}
sigrity::update cktdef {R30@@PORT_U9_H9_G7_MODEL} -head {ExtNode = H9 G7} -Definition {Rport H9 G7 1.0e-6} -check {!}
sigrity::update circuit {R30@@PORT_U9_H9_G7} -manual {enable} {!}

# Create circuit for components (model missing) in xnet

# Set frequency
sigrity::update freq -freq {1.000000e+06, 1.000000e+06, 0, linear, 3} {!}

# Output options
sigrity::update option -AutoSaveSimuResult {1} -ResultFileHasTouchstone {0} -ResultFileHasTouchstone2 {1} -ResultFileHasBnp {0} {!}
# PowerDC option
sigrity::update option -PCEnforcementByBBS {0} -PDCEqualPotential {1} -CalcDCPoint {1} {!}

# Save
sigrity::save {!}

# Begin simulation
sigrity::begin Simul {!}

