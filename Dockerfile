FROM ubuntu:22.04

ENV WORKSPACE_DIR=/root
ENV FIRMWARE_DIR=${WORKSPACE_DIR}/Firmware

ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
ENV DISPLAY=:99
ENV LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y bc \
    cmake \
    curl \
    sudo \
    lsb-release \
    wget \
    git && \
    apt-get -y autoremove && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*


RUN git clone --recursive https://github.com/PX4/PX4-Autopilot.git ${FIRMWARE_DIR} && \
    cd ${FIRMWARE_DIR} && \
    bash ./Tools/setup/ubuntu.sh --no-nuttx

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

RUN cd ${FIRMWARE_DIR} && make px4_sitl_default

ENTRYPOINT ["/root/entrypoint.sh"]
