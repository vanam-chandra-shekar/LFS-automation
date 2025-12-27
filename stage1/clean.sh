LFS="/mnt/lfs"
USBIMG="usb.img"
LFS_DISK=$(losetup -j "$USBIMG" | cut -d: -f1)


if [[ $EUID -ne 0 ]]; then
    echo "Run this script as root"
    exit 1
fi


if grep -q "$LFS" /proc/mounts ; then
    echo "Found LFS mount unmounting"
    umount "$LFS"
fi


if [[ -n "$LFS_DISK" ]]; then
    echo "Found LFS loop device disconnecting."
    sudo losetup -d "$LFS_DISK"
fi


if [[ -f "$USBIMG" ]]; then
    echo "Found USB image removing."
    rm -f "$USBIMG"
fi

echo "Cleaned"
