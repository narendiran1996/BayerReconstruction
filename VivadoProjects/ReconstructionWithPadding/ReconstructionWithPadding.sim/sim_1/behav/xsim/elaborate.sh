#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun Jun 06 07:44:43 IST 2021
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto adf20cf6e2c04e7d8a017c65caa09771 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tbBayerReconstructionTestOut_behav xil_defaultlib.tbBayerReconstructionTestOut xil_defaultlib.glbl -log elaborate.log"
xelab -wto adf20cf6e2c04e7d8a017c65caa09771 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tbBayerReconstructionTestOut_behav xil_defaultlib.tbBayerReconstructionTestOut xil_defaultlib.glbl -log elaborate.log

