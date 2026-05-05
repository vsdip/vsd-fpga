#!/usr/bin/env bash
set -e

mkdir -p "${HOME}/.vnc"

if [ ! -f "${HOME}/.vnc/passwd" ]; then
  printf "vscode\nvscode\n\n" | vncpasswd
fi

vncserver -kill :1 >/dev/null 2>&1 || true
vncserver :1 -geometry "${VNC_GEOMETRY:-1600x900}" -depth "${VNC_DEPTH:-24}"

NOVNC_DIR="/usr/share/novnc"

websockify --web="$NOVNC_DIR" 6080 localhost:5901 &

echo "noVNC desktop is available on port 6080"
echo "VNC password: vscode"

sleep infinity
