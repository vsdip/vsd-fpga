FROM mcr.microsoft.com/devcontainers/base:ubuntu-20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_GEOMETRY=1600x900
ENV VNC_DEPTH=24

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    ca-certificates \
    wget \
    curl \
    git \
    bash \
    tar \
    gzip \
    unzip \
    zip \
    xz-utils \
    file \
    locales \
    tzdata \
    build-essential \
    make \
    gcc \
    g++ \
    perl \
    python \
    python3 \
    python3-pip \
    libtinfo5 \
    libncurses5 \
    libncursesw5 \
    libstdc++6 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libxft2 \
    libxss1 \
    libgtk2.0-0 \
    libgtk-3-0 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libglib2.0-0 \
    libsm6 \
    libice6 \
    libfontconfig1 \
    libfreetype6 \
    libdbus-glib-1-2 \
    libusb-1.0-0 \
    xterm \
    dbus-x11 \
    xfce4 \
    xfce4-terminal \
    tigervnc-standalone-server \
    tigervnc-common \
    novnc \
    websockify \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

COPY start-vnc.sh /usr/local/bin/start-vnc.sh
RUN chmod +x /usr/local/bin/start-vnc.sh

USER vscode
WORKDIR /home/vscode

RUN mkdir -p /home/vscode/.vnc \
    && printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &\n' > /home/vscode/.vnc/xstartup \
    && chmod +x /home/vscode/.vnc/xstartup

EXPOSE 6080 5901

CMD ["sleep", "infinity"]
