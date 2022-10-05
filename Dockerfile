# cat Dockerfile
# FROM registry.access.redhat.com/rhel7/rhel-tools
# MAINTAINER jeder@redhat.com
FROM ubuntu:latest as dependencies

# Uncomment to setup VFIO device
#COPY ./setup_vfio.sh /root/setup_vfio.sh
#RUN /root/setup_vfio.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install pkg-config \
                       python3 \
                       meson \
                       ninja-build \
                       libnuma-dev \
#                       linux-headers-$(uname -r) \
                       wget \
                       build-essential

# --- dpdk ---
FROM dependencies as dpdk

WORKDIR /root

ENV RTE_VERSION=20.11.6
ENV RTE_SDK=/root/dpdk-stable-$RTE_VERSION
ENV RTE_TARGET=x86_64-native-linux-gcc

COPY ./build_dpdk.sh ./build_dpdk.sh
RUN ./build_dpdk.sh

# --- ping pong ---
FROM dpdk as pingpong

COPY ./dpdk-pingpong ./dpdk-pingpong
WORKDIR /root/dpdk-pingpong

RUN make

CMD ["/usr/bin/bash"]
