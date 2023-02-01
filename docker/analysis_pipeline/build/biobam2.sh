BB_INST=$OPT/biobambam2
curl -sSL --retry 10 -o distro.tar.xz "https://gitlab.com/german.tischler/biobambam2/uploads/178774a8ece96d2201fcd0b5249884c7/biobambam2-2.0.146-release-20191030105216-x86_64-linux-gnu.tar.xz";
mkdir -p $BB_INST
tar --strip-components 3 -C $BB_INST -Jxf distro.tar.xz
rm -f $BB_INST/bin/curl
