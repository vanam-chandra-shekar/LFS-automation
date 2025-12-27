SCRIPTDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export USBPATH="$SCRIPTDIR/usb.img"
export LFS=/mnt/lfs
export USR=lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export CLEANBUILD=1
export CLEANENV=0



