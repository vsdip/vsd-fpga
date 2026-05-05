#!/usr/bin/env bash
set -e

mkdir -p "$HOME/.local/bin"

if ! grep -q "Xilinx/Vivado 2019.2" "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOT'

# Xilinx/Vivado 2019.2 environment
if [ -f /tools/Xilinx/Vivado/2019.2/settings64.sh ]; then
  source /tools/Xilinx/Vivado/2019.2/settings64.sh
fi
EOT
fi

echo "Codespace is ready. Open port 6080 for noVNC."
echo "To install Vivado 2019.2, run:"
echo "  bash scripts/install-xilinx-2019.2.sh"
