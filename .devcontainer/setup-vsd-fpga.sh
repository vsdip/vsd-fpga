#!/usr/bin/env bash
set -e

echo "=================================================="
echo " VSD FPGA Fabric Workshop Environment Check"
echo "=================================================="

echo ""
echo "Disk space:"
df -h /

echo ""
echo "Checking tools..."

check_tool() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "[OK] $1 -> $(command -v "$1")"
    else
        echo "[MISSING] $1"
    fi
}

check_tool git
check_tool gcc
check_tool g++
check_tool cmake
check_tool make
check_tool python3
check_tool iverilog
check_tool gtkwave
check_tool verilator
check_tool yosys
check_tool vpr
check_tool openfpga

echo ""
echo "Environment variables:"
echo "VSD_TOOLS=${VSD_TOOLS:-not set}"
echo "VTR_ROOT=${VTR_ROOT:-not set}"
echo "OPENFPGA_ROOT=${OPENFPGA_ROOT:-not set}"

echo ""
echo "Final disk usage:"
df -h /

echo ""
echo "Setup check complete."
