rm -rf distro
git clone --recursive https://github.com/bwa-mem2/bwa-mem2.git distro
cd distro
git checkout ${VERSION}
make -j$CPU multi
cp bwa-mem2* $OPT/bin
