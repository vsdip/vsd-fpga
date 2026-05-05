FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    autoconf \
    automake \
    bison \
    flex \
    g++ \
    gcc \
    g++-11 \
    gcc-11 \
    clang \
    clang-format \
    cmake \
    make \
    ninja-build \
    ccache \
    git \
    git-lfs \
    curl \
    wget \
    unzip \
    zip \
    tar \
    rsync \
    time \
    tree \
    vim \
    nano \
    less \
    file \
    pkg-config \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-venv \
    python3-lxml \
    python3-tk \
    perl \
    tcl \
    tcl-dev \
    tcl8.6-dev \
    tcllib \
    expect \
    swig \
    gperf \
    texinfo \
    doxygen \
    gtkwave \
    iverilog \
    verilator \
    yosys \
    graphviz \
    x11-apps \
    libfl-dev \
    libffi-dev \
    libevent-dev \
    libcairo2-dev \
    libfontconfig1-dev \
    fontconfig \
    libx11-dev \
    libxft-dev \
    libxml2-dev \
    libxml++2.6-dev \
    libxml2-utils \
    libgtk-3-dev \
    libreadline-dev \
    libncurses5-dev \
    libssl-dev \
    zlib1g-dev \
    xvfb \
xfce4 \
xfce4-session \
xfce4-panel \
xfdesktop4 \
xfwm4 \
xfce4-terminal \
thunar \
dbus-x11 \
x11vnc \
novnc \
websockify \
supervisor \
x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && python3 -m pip install --no-cache-dir \
       numpy \
       pandas \
       matplotlib \
       pyyaml \
       lxml \
       psutil \
       scipy \
       jinja2 \
       pyparsing \
       humanize

RUN mkdir -p /opt/vsd-tools /workspaces

ENV VSD_TOOLS=/opt/vsd-tools
ENV VTR_ROOT=/opt/vsd-tools/vtr-verilog-to-routing
ENV OPENFPGA_ROOT=/opt/vsd-tools/OpenFPGA

ENV PATH="${VTR_ROOT}/build/vtr-verilog-to-routing/bin:${VTR_ROOT}/vpr:${VTR_ROOT}/abc:${OPENFPGA_ROOT}/openfpga:${OPENFPGA_ROOT}/build/openfpga:${PATH}"

USER vscode
WORKDIR /workspaces/vsd-fpga
