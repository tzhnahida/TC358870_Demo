################################################################################
# 
# This work may not be copied, modified, re-published, uploaded,
# executed, or distributed in any way, in any medium, whether in
# whole or in part, without prior written permission from Cadence
# Design Systems, Inc.
#
# Design: #Taaaach15224
# Created: Mon Jun 29 18:52:44 2026
################################################################################

# Set working directory
set CurrentPath [sigrity::debug TCLFolderPath {1} {!}]

# Set translator log file name
set CaseTrLogFileName "#Taaaach15224_qf_tr.log"

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

