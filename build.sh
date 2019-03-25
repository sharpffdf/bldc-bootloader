#!/bin/bash
MAIN_PATH="`pwd`"

pushd $MAIN_PATH > /dev/null 2>&1
if [ "${1}" = "c" ]; then
    make clean
else
    # mkdir ./build/obj -p
    make
    cp $MAIN_PATH/build/BLDC_4_Bootloader.bin $MAIN_PATH/build/VESC_default_"${GIT_VERSION}".bin
    GIT_VERSION=`$MAIN_PATH/gitVersion.sh`
    arm-none-eabi-objcopy -Oihex $MAIN_PATH/build/BLDC_4_Bootloader.elf $MAIN_PATH/build/BLDC_4_Bootloader_"${GIT_VERSION}".hex
    # # arm-none-eabi-size $MAIN_PATH/build/BLDC_4_Bootloader.elf
    cp $MAIN_PATH/build/BLDC_4_Bootloader_"${GIT_VERSION}".hex /home/lf/dev/tools/vesc/bl.hex
fi
popd > /dev/null 2>&1
