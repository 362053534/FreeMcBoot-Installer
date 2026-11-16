
PKG_DATE=$(date '+[%Y-%m-%d]')
cp ../Changelog.md __base/Changelog.md
for subdir in 1965
do
    echo packing v$subdir into ../FMCB-$subdir.7z
    NEWDIR="FMCBinst-$subdir-$PKG_DATE"
    cp -r __base/ $NEWDIR/
    cp -r $subdir/INSTALL/ $NEWDIR/INSTALL/
    echo $SHA8>$NEWDIR/lang/commit.txt
    echo "title=FreeMcBoot v$subdir $PKG_DATE" >$NEWDIR/title.cfg
    echo "boot=FMCBInstaller.elf">>$NEWDIR/title.cfg
    cp FMCBInstaller.elf $NEWDIR/
    cp FMCBInstaller_EXFAT.elf $NEWDIR/
    mkdir -p $NEWDIR/FMCB_EXFAT/
    mkdir -p $NEWDIR/FMCB_EXFAT/SYS-CONF/
    # exFAT 驱动直接用本版本 SYS-CONF 里的，不再下载 BDMAssault
    cp $subdir/INSTALL/SYS-CONF/USBD.IRX $subdir/INSTALL/SYS-CONF/USBHDFSD.IRX $NEWDIR/FMCB_EXFAT/SYS-CONF/
    cp EXFAT_INSTALL_INSTRUCTIONS.TXT $NEWDIR/FMCB_EXFAT/INSTRUCTIONS.TXT
    7z a -t7z -r ../FMCB-$subdir.7z $NEWDIR/*
done
