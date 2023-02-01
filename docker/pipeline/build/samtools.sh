curl -sSL --retry 10 -o distro.tar.bz2 https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2
tar --strip-components 1 -xjf distro.tar.bz2
./configure --enable-plugins --enable-libcurl --with-htslib=$OPT --prefix=$OPT
make clean
make -j$CPU all
make install
