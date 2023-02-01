rm -rf $OPT/scramble
mkdir -p $OPT/scramble
curl -sSL --retry 10 -o distro.tar.gz "https://sourceforge.net/projects/staden/files/staden/2.0.0b11/staden-2.0.0b11-2016-linux-x86_64.tar.gz"
mkdir -p distro
rm -rf distro/*
tar --strip-components 1 -C distro -xzf distro.tar.gz
cp -r distro/* $OPT/scramble
