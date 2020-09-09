# cat Dockerfile
# FROM registry.access.redhat.com/rhel7/rhel-tools
# MAINTAINER jeder@redhat.com
FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install python3 \
                       meson \
                       ninja-build \
                       linux-headers-$(uname -r) \
                       wget \
                       build-essential

WORKDIR /root

# Build DPDK and pktgen-dpdk for x86_64-native-linuxapp-gcc.
COPY ./build_dpdk.sh /root/build_dpdk.sh
RUN /root/build_dpdk.sh

# Setup VFIO device
COPY ./setup_vfio.sh /root/setup_vfio.sh
RUN /root/setup_vfio.sh

COPY ./pingpong /root/pingpong

# Defaults to a bash shell, you could put your DPDK-based application here.
CMD ["/usr/bin/bash"]
