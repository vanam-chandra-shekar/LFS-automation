
if [[ $EUID -ne 0 ]]; then
    echo "Run this script as Sudo"
    exit 1
fi


export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-gnu


if ! grep -q "$LFS" /proc/mounts; then
    echo "Not Mounted"
    source ./setupdisk.sh 
    sudo mkdir -vp "$LFS"
    sudo mount "${LFS_DISK}p2" "${LFS}"
    sudo chown -v $USER "$LFS"
fi

