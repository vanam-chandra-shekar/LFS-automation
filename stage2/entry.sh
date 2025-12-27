

export SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export PARENT_DIR=$(dirname $SCRIPT_DIR)


if [[ -z "$LFS" ]] || ! grep -qs "$LFS" /proc/mounts ; then

    echo "Run Stage One and restart the Bash."
    exit 1
fi


if [[ -z "$USR" ]]; then
    echo "Run Stage One Fully and restart bash."
    exit 1
fi

if [[ "$(id -un)" != "$USR" ]]; then

    echo "Run as $USR user."
    exit 1
fi


source $PARENT_DIR/packageinstall.sh 0 binutils 


