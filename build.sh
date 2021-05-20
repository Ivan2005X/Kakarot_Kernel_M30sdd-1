#
#!/bin/bash
IMAGE=out/arch/arm64/boot/Image;
AIKDIR=~/m30s/PRISH/AIK;
BOTIMG=${AIKDIR}/split_img/boot.img-zImage;
NEWIMG=${AIKDIR}/image-new.img
CURDIR=~/m30s;
echo "Setting Up Environment"
echo ""
export ARCH=arm64
export SUBARCH=arm64
export ANDROID_MAJOR_VERSION=r
export PLATFORM_VERSION=11.0.0

# Export KBUILD flags
export KBUILD_BUILD_USER=davinash97 #neel0210 who?
export KBUILD_BUILD_HOST=ExynosLab #hell

# CCACHE
export CCACHE=ccache

# TC LOCAL PATH
export CROSS_COMPILE=~/toolchain/bin/aarch64-linux-gnu-
export CLANG_TRIPLE=~/clang/bin/aarch64-linux-gnu-
export CC=~/clang/bin/clang

if [ ! -f "usr/magisk/update_magisk.sh" ]; then
   . ./usr/magisk/update_magisk.sh
fi
make m30s_defconfig O=output
make -j$(($(nproc) + 1)) O=out
if [ -f $IMAGE ]; then
    echo "Kernel Compiled";
    cp $IMAGE $BOTIMG;
    cd $AIKDIR;
    . ./repackimg.sh;
    if [ -f ${NEWIMG} ]; then
        cp -r ${NEWIMG} ../ZIP/PRISH/D/M30S/boot.img
        cd ../ZIP
        if [ -f Carrot*.zip ]; then
        rm -f Carrot*.zip;
        fi
        zip -r9 Carrot-Kernel_M30sdd-$(date +"%Y-%m-%d").zip *
        cp *.zip ${CURDIR}/
        cd $CURDIR;
    else
        cd $CURDIR;
        echo "Image-new.img missing"
    fi
else
    echo "Error Occured"
fi