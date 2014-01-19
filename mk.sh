# define
kdir=`readlink -f .`
cd ..
home=`readlink -f .`
ramdisk=$kdir/usr/cm_initramfs.list
toolchain=$home/toolchain/arm-eabi-4.6/bin/arm-eabi-
version=Dev
export ARCH=arm
export CROSS_COMPILE=$toolchain
cd $kdir
mkdir out
mkdir $home/temp
rm -rf $home/temp/*
rm $kdir/pack/system/lib/modules/*
rm -rf out/*
rm -rf ./pack/boot/zImage
mv .git git
make cyanogenmod_i9100_defconfig
make mrproper
make cyanogenmod_i9100_defconfig
rm -rf $kdir/pack/system/lib/modules/*
make -j16 CONFIG_INITRAMFS_SOURCE="$ramdisk"
find . -name "*.ko" -exec mv {} $kdir/pack/system/lib/modules/ \;
$home/toolchain/arm-linux-androideabi-4.6/bin/arm-linux-androideabi-strip --strip-unneeded $kdir/pack/system/lib/modules/*
cp $kdir/arch/arm/boot/zImage $kdir/pack/boot/
cd $kdir/pack
zip -r Cyan_11.$version.$(date -u +%Y%m%d).zip ./
mv ./*.zip ../out/
cd $kdir
make mrproper
mv git .git
