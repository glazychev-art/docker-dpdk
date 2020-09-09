# cat setup_vfio.sh
#!/bin/bash

cd /dev
mkdir vfio

cd vfio
mknod 83 c 243 0
mknod vfio c 10 196
