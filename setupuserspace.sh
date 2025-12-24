#!/usr/bin/env bash

set -e

mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

case $(uname -m) in
    x86_64) mkdir -pv "$LFS/usr/lib64";;
esac

for i in bin lib sbin; do
    ln -snfv usr/$i $LFS/$i
done 

case $(uname -m) in
    x86_64) ln -snfv usr/lib64 $LFS/lib64;
esac

mkdir -pv "$LFS/tools"



if ! getent group lfs >/dev/null; then
    groupadd lfs
    echo "Group lfs added"
else
    echo "Group already exists"
fi


if ! id lfs &>/dev/null; then
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs
    echo "User lfs added"
else
    echo "User lfs already exists"
fi


chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
    x86_64) chown -v lfs "$LFS/lib64"
esac

su - lfs





