#
#!/bin/bash
clear
CURDIR=~/m30s;
IMAGE=${CURDIR}/out/arch/arm64/boot/Image;
AIKDIR=${CURDIR}/PRISH/AIK;
BOTIMG=${AIKDIR}/split_img/boot.img-zImage;
NEWIMG=${AIKDIR}/image-new.img
if [ -f $IMAGE ]; then
    rm $IMAGE;
fi
if [ -f $BOTIMG ]; then
    rm $BOTIMG;
fi
if [ -f $NEWIMG ]; then
    rm $NEWIMG;
fi
if [ -f Carrot*.zip ]; then
    rm -f Carrot*.zip;
fi
if [ -f ${CURDIR}/PRISH/ZIP/boot.img ]; then
    rm -f ${CURDIR}/PRISH/ZIP/boot.img
fi
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
export CROSS_COMPILE=../../clang/bin/aarch64-linux-gnu-
export CLANG_TRIPLE=../../clang/bin/aarch64-linux-gnu-
export CC=../../clang/bin/clang
export LOCALVERSION="Gang Gang for M30s by DAvinash97"
curl https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${CHAT_ID} -F text="Started Compiling kernel for M30s"
make m30s_defconfig O=out
make -j$(($(nproc) + 1)) O=out
if [ -f $IMAGE ]; then
    echo "Kernel Compiled";
    cp $IMAGE $BOTIMG;
    cd $AIKDIR;
    . ./repackimg.sh;
    if [ -f ${NEWIMG} ]; then
        cp -r ${NEWIMG} ../ZIP/boot.img
        cd ../ZIP
        zip -r9 Carrot-Kernel_M30sdd-$(date +"%Y-%m-%d").zip *
        cp *.zip ${CURDIR}/
        cd $CURDIR;
        for i in *.zip
        do
            curl https://api.telegram.org/bot${BOT_TOKEN}/sendDocument?chat_id=${CHAT_ID} -F document=@${i}
        done
    else
        cd $CURDIR;
        echo "Image-new.img missing"
    fi
else
    curl --url https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${CHAT_ID} -F text="Looks Like an error. Need to check the build log"
    echo "Error Occured"
fi
