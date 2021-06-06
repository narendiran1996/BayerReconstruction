#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun Jun 06 07:44:44 IST 2021
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim tbBayerReconstructionTestOut_behav -key {Behavioral:sim_1:Functional:tbBayerReconstructionTestOut} -tclbatch tbBayerReconstructionTestOut.tcl -view /mnt/18C846EDC846C928/DeMosaicBased/VivadoProjects/ReconstructionWithPadding/tbBayerReconstructionTestOut_behav.wcfg -log simulate.log"
xsim tbBayerReconstructionTestOut_behav -key {Behavioral:sim_1:Functional:tbBayerReconstructionTestOut} -tclbatch tbBayerReconstructionTestOut.tcl -view /mnt/18C846EDC846C928/DeMosaicBased/VivadoProjects/ReconstructionWithPadding/tbBayerReconstructionTestOut_behav.wcfg -log simulate.log

