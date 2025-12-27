SRCDIR=$1
BUILDIR="$SRCDIR/build"

if [[ "$CLEANBUILD" -eq 1 && -d "$BUILDIR" ]]; then
    echo "Clearing Previous Builds"
    rm -rf $BUILDIR
fi

mkdir -pv $BUILDIR

pushd $BUILDIR > /dev/null

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror    \
             --enable-new-dtags  \
             --enable-default-hash-style=gnu\
&& make \
&& make install

popd > /dev/null

