
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

if [ ! -f /home/$USR/.bash_profile ]; then
    cat << EOF >  /home/$USR/.bash_profile 
exec env -i HOME=\$HOME TERM=\$TERM PS1='$PS1' /bin/bash
EOF
fi

if [ ! -f /home/$USR/.bashrc ]; then
    cat << EOF > /home/$USR/.bashrc
set +h
umask 022
LFS=$LFS
LC_ALL=POSIX
LFS_TGT=$LFS_TGT
PATH='/usr/bin'
if [ ! -L /bin ]; then PATH=/bin:\$PATH; fi
PATH=$LFS/tools/bin:\$PATH
CONFIG_SITE=$LFS/usr/share/config.site
USR=$USR
CLEANENV=$CLEANENV
CLEANBUILD=$CLEANBUILD
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE USR CLEANENV CLEANBUILD
EOF
fi

chown -v $USR:$USR /home/$USR/.bashrc
chown -v $USR:$USR /home/$USR/.bash_profile

