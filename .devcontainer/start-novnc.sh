#!/usr/bin/env bash
set -e

export DISPLAY=:1
export USER=vscode
export HOME=/home/vscode

mkdir -p /tmp/vsd-novnc-logs

echo "Starting lightweight noVNC desktop..."

# Avoid starting duplicate services
if pgrep -f "Xvfb :1" >/dev/null 2>&1; then
    echo "Xvfb already running"
else
    nohup Xvfb :1 -screen 0 1280x800x24 -ac +extension GLX +render -noreset \
        > /tmp/vsd-novnc-logs/xvfb.log 2>&1 &
    sleep 2
fi

if pgrep -f "openbox" >/dev/null 2>&1; then
    echo "Openbox already running"
else
    nohup openbox-session \
        > /tmp/vsd-novnc-logs/openbox.log 2>&1 &
    sleep 1
fi

if pgrep -f "x11vnc.*:1" >/dev/null 2>&1; then
    echo "x11vnc already running"
else
    nohup x11vnc -display :1 -nopw -forever -shared -rfbport 5901 -quiet \
        > /tmp/vsd-novnc-logs/x11vnc.log 2>&1 &
    sleep 1
fi

if pgrep -f "websockify.*6080" >/dev/null 2>&1; then
    echo "websockify/noVNC already running"
else
    nohup websockify 0.0.0.0:6080 localhost:5901 --web=/usr/share/novnc \
        > /tmp/vsd-novnc-logs/websockify.log 2>&1 &
    sleep 1
fi

echo "noVNC started."
echo "Open Codespaces Ports tab, then open port 6080."
echo "If required, open: /vnc.html or /vnc_lite.html"
