curl -sSL --retry 10 https://github.com/ebiggers/libdeflate/archive/refs/tags/${VERSION}.tar.gz > distro.tar.gz;
file distro.tar.gz;
tar -xzv --strip-components 1 -f distro.tar.gz;
PREFIX=$OPT make -j$CPU CFLAGS="-fPIC -O3" install;
