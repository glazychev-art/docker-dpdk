# cat build_dpdk.sh
#!/bin/bash

VERSION=20.08
URL=http://fast.dpdk.org/rel/dpdk-$VERSION.tar.xz

# Download/Build DPDK
wget -q $URL
tar xf dpdk-$VERSION.tar.xz

cd dpdk-$VERSION
meson build

cd build
ninja
ninja install
ldconfig
