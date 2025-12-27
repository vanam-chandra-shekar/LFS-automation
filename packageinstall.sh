set -euo pipefail

if [[ -z "$LFS" ]]; then
    echo "Do not Run directly"
    exit 1
fi

PACKAGE=$2
PASS=$1

export SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BUILDIR="$SCRIPT_DIR/buildscripts"
STAMPDIR="$LFS/sources/.stamp"

mkdir -pv  $STAMPDIR


if [[ -f "$STAMPDIR/$PACKAGE-$PASS.done" ]]; then
    echo "Already compiled $PACKAGE. Skipping"
    return 0
fi

cat $SCRIPT_DIR/packages.csv | grep -i "^$PACKAGE," | grep -i -v  "\.patch," | while read line; do
    VERSION=$(echo $line | cut -d, -f2)
    URL=$(echo $line | cut -d, -f4 | sed "s/@/$VERSION/g")
    FILENAME=$(basename $URL)
    LOC="$LFS/sources/$FILENAME"
    DIRLOC=$(echo $FILENAME | sed "s/\(.*\)\.tar\..*/\1/")
    DIRLOC="$LFS/sources/$DIRLOC"
    
    mkdir -pv "$DIRLOC"
    
    echo "Extracting $LOC"
    tar -xf "$LOC" -C "$DIRLOC"

    pushd $DIRLOC > /dev/null
    
    if [ "$(ls -1A | wc -l)" == 1 ]; then
        mv $(ls -1A)/* ./
    fi 

    popd > /dev/null
    
    BUILDSCRIPT="$BUILDIR/$PACKAGE.sh"
    if [[ $PASS -gt 0 ]]; then
       BUILDSCRIPT="$BUILDIR/$PACKAGE-$PASS.sh" 
    fi
    
    echo "BUILDING $PACKAGE"
    
    if ! source $BUILDSCRIPT $DIRLOC | tee "$SCRIPT_DIR/build.log" ; then
        echo "Failed to Build $PACKAGE"        
        return 1
    fi

    echo "DONE"
    touch "$STAMPDIR/$PACKAGE-$PASS.done"
done 

