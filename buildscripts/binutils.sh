SRCDIR=$1
BUILDIR="$SRCDIR/build"

if [[ -L $BUILDIR ]]; then
    echo "Clearing Previous Builds"
    rm -r $BUILDIR
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

