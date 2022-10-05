# cat build_dpdk.sh
#!/bin/bash

URL=http://fast.dpdk.org/rel/dpdk-$RTE_VERSION.tar.xz

wget -q $URL
tar xf dpdk-$RTE_VERSION.tar.xz

cd dpdk-stable-$RTE_VERSION
meson build

cd build
ninja
ninja install
ldconfig
