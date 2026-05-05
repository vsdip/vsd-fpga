FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DISPLAY=:1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# ------------------------------------------------------------
# Base packages + FPGA / EDA dependencies + lightweight noVNC
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    autoconf \
    automake \
    bison \
    flex \
    gcc \
    g++ \
    gcc-11 \
    g++-11 \
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
    graphviz \
    iverilog \
    verilator \
    gtkwave \
    yosys \
    x11-apps \
    xvfb \
    openbox \
    xterm \
    dbus-x11 \
    x11vnc \
    novnc \
    websockify \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Python packages
# ------------------------------------------------------------
RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel && \
    python3 -m pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    pyyaml \
    lxml \
    psutil \
    scipy \
    jinja2 \
    pyparsing \
    humanize \
    pytest

# ------------------------------------------------------------
# Tool environment
# ------------------------------------------------------------
ENV VSD_TOOLS=/opt/vsd-tools
ENV VTR_ROOT=/opt/vsd-tools/vtr-verilog-to-routing
ENV OPENFPGA_ROOT=/opt/vsd-tools/OpenFPGA

RUN mkdir -p ${VSD_TOOLS}

# ------------------------------------------------------------
# Build VTR
# ------------------------------------------------------------
RUN cd ${VSD_TOOLS} && \
    git clone --depth 1 --recursive --shallow-submodules \
        https://github.com/verilog-to-routing/vtr-verilog-to-routing.git && \
    cd ${VTR_ROOT} && \
    git submodule update --init --recursive --depth 1 || true && \
    make -j2 CMAKE_PARAMS="-DCMAKE_BUILD_TYPE=Release -DVPR_USE_EZGL=ON" && \
    find ${VTR_ROOT} -type d -name ".git" -prune -exec rm -rf {} + || true && \
    find ${VTR_ROOT} -type d -name "CMakeFiles" -prune -exec rm -rf {} + || true && \
    rm -rf ${VTR_ROOT}/build/libs/EXTERNAL/libcatch2* || true

# ------------------------------------------------------------
# Build OpenFPGA
# ------------------------------------------------------------
RUN cd ${VSD_TOOLS} && \
    git clone --depth 1 --recursive --shallow-submodules \
        https://github.com/LNIS-Projects/OpenFPGA.git && \
    cd ${OPENFPGA_ROOT} && \
    git submodule update --init --recursive --depth 1 || true && \
    if [ -f requirements.txt ]; then python3 -m pip install --no-cache-dir -r requirements.txt || true; fi && \
    make -j2 BUILD_TYPE=release INSTALL_DOC=OFF CMAKE_GOALS=openfpga \
        CMAKE_FLAGS="-DOPENFPGA_WITH_TEST=OFF -DOPENFPGA_WITH_SWIG=OFF -DOPENFPGA_WITH_YOSYS=OFF -DOPENFPGA_ENABLE_STRICT_COMPILE=OFF" || \
    make -j2 BUILD_TYPE=release INSTALL_DOC=OFF && \
    find ${OPENFPGA_ROOT} -type d -name ".git" -prune -exec rm -rf {} + || true && \
    find ${OPENFPGA_ROOT} -type d -name "CMakeFiles" -prune -exec rm -rf {} + || true

# ------------------------------------------------------------
# PATH setup
# ------------------------------------------------------------
ENV PATH="${VTR_ROOT}/build/vtr-verilog-to-routing/bin:${VTR_ROOT}/build/vpr:${VTR_ROOT}/vpr:${VTR_ROOT}/abc:${OPENFPGA_ROOT}/openfpga:${OPENFPGA_ROOT}/build/openfpga:${OPENFPGA_ROOT}/build/openfpga/openfpga:${PATH}"

RUN echo 'export VSD_TOOLS=/opt/vsd-tools' >> /etc/bash.bashrc && \
    echo 'export VTR_ROOT=/opt/vsd-tools/vtr-verilog-to-routing' >> /etc/bash.bashrc && \
    echo 'export OPENFPGA_ROOT=/opt/vsd-tools/OpenFPGA' >> /etc/bash.bashrc && \
    echo 'export DISPLAY=:1' >> /etc/bash.bashrc && \
    echo 'export PATH=$VTR_ROOT/build/vtr-verilog-to-routing/bin:$VTR_ROOT/build/vpr:$VTR_ROOT/vpr:$VTR_ROOT/abc:$OPENFPGA_ROOT/openfpga:$OPENFPGA_ROOT/build/openfpga:$OPENFPGA_ROOT/build/openfpga/openfpga:$PATH' >> /etc/bash.bashrc

# ------------------------------------------------------------
# Make sure vscode user owns useful directories
# ------------------------------------------------------------
RUN chown -R vscode:vscode /opt/vsd-tools || true

EXPOSE 6080

USER vscode
WORKDIR /workspaces/vsd-fpga
