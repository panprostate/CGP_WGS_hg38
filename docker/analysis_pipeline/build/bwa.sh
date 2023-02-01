curl -sSL --retry 10 -o distro.tar.gz https://github.com/lh3/bwa/archive/${VERSION}.tar.gz
tar --strip-components 1 -zxf distro.tar.gz
make -j$CPU
cp distro/bwa $OPT/bin
