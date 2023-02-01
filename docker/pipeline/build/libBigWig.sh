curl -sSL --retry 10 https://github.com/dpryan79/libBigWig/archive/${VERSION}.tar.gz > distro.tar.gz
tar --strip-components 1 -xzf distro.tar.gz
make clean
make -j$CPU install prefix=$OPT
