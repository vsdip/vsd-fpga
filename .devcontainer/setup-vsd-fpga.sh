#!/usr/bin/env bash
set -e

echo "=================================================="
echo " VSD FPGA Fabric Workshop Environment Check"
echo "=================================================="

echo ""
echo "Disk space:"
df -h /

echo ""
echo "Checking GUI / noVNC services:"
pgrep -a Xvfb || true
pgrep -a x11vnc || true
pgrep -a websockify || true
pgrep -a xfce4 || true
pgrep -a supervisord || true

echo ""
echo "Checking port 6080:"
ss -ltnp | grep 6080 || true

echo ""
echo "Checking tools:"

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
check_tool Xvfb
check_tool x11vnc
check_tool websockify
check_tool supervisord

echo ""
echo "Environment:"
echo "DISPLAY=${DISPLAY:-not set}"
echo "VSD_TOOLS=${VSD_TOOLS:-not set}"
echo "VTR_ROOT=${VTR_ROOT:-not set}"
echo "OPENFPGA_ROOT=${OPENFPGA_ROOT:-not set}"

echo ""
echo "If noVNC does not open automatically:"
echo "1. Go to Codespaces Ports tab"
echo "2. Open port 6080"
echo "3. Click vnc_lite.html"

echo ""
echo "Environment check complete."
