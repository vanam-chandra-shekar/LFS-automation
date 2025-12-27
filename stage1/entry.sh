
if [[ $EUID -ne 0 ]]; then
    echo "Run this script as Sudo"
    exit 1
fi

export SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export PARENT_DIR=$(dirname $SCRIPT_DIR)


set -a
source $PARENT_DIR/config.sh
set +a



if ! grep -q "$LFS" /proc/mounts; then
    echo "Not Mounted"
    source $SCRIPT_DIR/setupdisk.sh 
    sudo mkdir -vp "$LFS"
    sudo mount "${LFS_DISK}p2" "${LFS}"
fi


mkdir -vp $LFS/sources
sudo chmod -v a+wt $LFS/sources


source $SCRIPT_DIR/download.sh


source $SCRIPT_DIR/setuplfsuser.sh
