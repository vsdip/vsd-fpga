#!/usr/bin/env bash
set -euo pipefail

INSTALLER_URL="https://vsd-labs.sgp1.cdn.digitaloceanspaces.com/vsd-labs/Xilinx_Unified_2019.2_1106_2127_Lin64.bin"
INSTALLER_NAME="Xilinx_Unified_2019.2_1106_2127_Lin64.bin"

DOWNLOAD_DIR="$HOME/xilinx-downloads"
EXTRACT_DIR="$HOME/xilinx-installer-2019.2"
CONFIG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/xilinx-install-config.txt"
INSTALL_ROOT="/tools/Xilinx"

mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

if [ ! -f "$INSTALLER_NAME" ]; then
  echo "Downloading Xilinx Unified Installer 2019.2..."
  wget -c "$INSTALLER_URL" -O "$INSTALLER_NAME"
else
  echo "Installer already exists: $DOWNLOAD_DIR/$INSTALLER_NAME"
fi

chmod +x "$INSTALLER_NAME"

rm -rf "$EXTRACT_DIR"
mkdir -p "$EXTRACT_DIR"

echo "Extracting installer to $EXTRACT_DIR..."
./"$INSTALLER_NAME" --keep --noexec --target "$EXTRACT_DIR"

if [ ! -x "$EXTRACT_DIR/xsetup" ]; then
  echo "ERROR: xsetup was not found after extraction."
  echo "Check whether the installer downloaded completely."
  exit 1
fi

echo "Creating install root: $INSTALL_ROOT"
sudo mkdir -p "$INSTALL_ROOT"
sudo chown -R "$USER:$USER" /tools

echo "Starting silent Vivado 2019.2 installation..."
echo "This accepts XilinxEULA, 3rdPartyEULA, and WebTalkTerms for this installation."

"$EXTRACT_DIR/xsetup" \
  --batch Install \
  --agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
  --config "$CONFIG_FILE"

if [ -f "$INSTALL_ROOT/Vivado/2019.2/settings64.sh" ]; then
  echo "Vivado settings found. Adding to shell environment."

  if ! grep -q "Vivado/2019.2/settings64.sh" "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" <<'EOT'

# Xilinx Vivado 2019.2
source /tools/Xilinx/Vivado/2019.2/settings64.sh
EOT
  fi
else
  echo "WARNING: settings64.sh not found at expected path. Check installation logs."
fi

echo "Installation step completed."
echo "Run this now, or open a new terminal:"
echo "  source /tools/Xilinx/Vivado/2019.2/settings64.sh"
echo "  vivado -version"
