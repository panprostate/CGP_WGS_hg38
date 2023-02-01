curl -sSL --retry 10 https://github.com/samtools/htslib/releases/download/${VERSION}/htslib-${VERSION}.tar.bz2 > distro.tar.bz2;
tar --strip-components 1 -jxf distro.tar.bz2;
./configure --enable-plugins --enable-libcurl --prefix=${OPT} \
  --with-libdeflate \
  CPPFLAGS="-I${OPT}/include" \
  LDFLAGS="-L${OPT}/lib -Wl,-R${OPT}/lib";
make clean;
make -j${CPU};
make install;
touch ${SETUP_DIR}/htslib.success;
