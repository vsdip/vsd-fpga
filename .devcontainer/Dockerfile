FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=vscode
ENV HOME=/home/vscode
ENV DISPLAY=:1
ENV VNC_GEOMETRY=1600x900
ENV VNC_DEPTH=24

RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list \
    && sed -i 's|http://security.ubuntu.com/ubuntu|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list \
    && sed -i 's|http://ports.ubuntu.com/ubuntu-ports|http://old-releases.ubuntu.com/ubuntu|g' /etc/apt/sources.list || true

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -o Acquire::Retries=10 \
               -o Acquire::http::Timeout=60 \
               -o Acquire::ftp::Timeout=60 \
               update

RUN apt-get -o Acquire::Retries=10 \
            -o Acquire::http::Timeout=60 \
            -o Dpkg::Options::="--force-confold" \
            install -y --no-install-recommends \
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

RUN useradd -s /bin/bash -m ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}

COPY start-vnc.sh /usr/local/bin/start-vnc.sh
RUN chmod +x /usr/local/bin/start-vnc.sh

USER ${USER}
WORKDIR ${HOME}

RUN mkdir -p ${HOME}/.vnc \
    && printf '#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &\n' > ${HOME}/.vnc/xstartup \
    && chmod +x ${HOME}/.vnc/xstartup

EXPOSE 6080 5901

CMD ["/usr/local/bin/start-vnc.sh"]
