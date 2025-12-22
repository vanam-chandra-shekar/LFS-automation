

if [[ $EUID -ne 0 ]]; then
    echo "Run this script as root(sudo)"
    exit 1
fi

#creating virtual image
USBPATH="usb.img"

if [[ ! -f "$USBPATH" ]]; then
    echo "Virtual Image $USBPATH missing"
    dd if=/dev/zero of="$USBPATH" bs=1M count=30720 status=progress
    echo "Created Virtual Image"
    LOOP=$(sudo losetup --find --show -P "$USBPATH")
    #parting the virtual disk

    sudo fdisk "$LOOP" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
EOF
    sudo mkfs -t ext4 "${LOOP}p2"
    sudo losetup -d "$LOOP"
    
fi


export LFS_DISK=$(losetup -j "$USBPATH" | cut -d: -f1)

if [[ -z "$LFS_DISK" ]]; then
    LFS_DISK=$(losetup --find --show -P "$USBPATH")
    echo "Attached $USBPATH to $LFS_DISK"
else
    echo "Already attached to $LFS_DISK"
fi






