#
#!/bin/bash

echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0

# Export KBUILD flags
export KBUILD_BUILD_USER=neel0210
export KBUILD_BUILD_HOST=hell

# CCACHE
export CCACHE="$(which ccache)"
export USE_CCACHE=1
ccache -M 50G
export CCACHE_COMPRESS=1

export CROSS_COMPILE=/home/neel/Desktop/toolchain/linaro/bin/aarch64-linux-gnu-
export CLANG_TRIPLE=/home/neel/Desktop/toolchain/clang/bin/aarch64-linux-gnu-
export CC=/home/neel/Desktop/toolchain/clang/bin/clan

echo "======================="
echo "Making kernel with ZIP"
echo "======================="
rm -rf out
clear
echo "======================="
echo "Making kernel with ZIP"
echo "======================="
make m30s_defconfig O=out CC=clang
make -j16 O=out CC=clang
echo "Kernel Compiled"