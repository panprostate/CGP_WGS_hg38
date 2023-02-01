set -eux;
export LFLAGS="-L${OPT}/lib"
curl -sSL --retry 10 https://github.com/cancerit/cgpBigWig/archive/refs/tags/${VERSION}.tar.gz > distro.tar.gz;
tar --strip-components 1 -xzf distro.tar.gz;
make -C c clean;
make -C c -j$CPU prefix=$OPT HTSLIB=$OPT/lib;
cp bin/bam2bedgraph $OPT/bin;
cp bin/bwjoin $OPT/bin;
cp bin/bam2bw $OPT/bin;
cp bin/bwcat $OPT/bin;
cp bin/bam2bwbases $OPT/bin;
cp bin/bg2bw $OPT/bin;
cp bin/detectExtremeDepth $OPT/bin;
make -C c clean;
