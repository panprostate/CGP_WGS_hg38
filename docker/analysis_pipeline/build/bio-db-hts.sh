cpanm --no-wget --no-interactive --notest --mirror http://cpan.metacpan.org -l $OPT Module::Build
cpanm --no-wget --no-interactive --notest --mirror http://cpan.metacpan.org -l $OPT XML::Parser
cpanm --no-wget --no-interactive --notest --mirror http://cpan.metacpan.org -l $OPT Bio::Root::Version
curl -sSL --retry 10 -o distro.tar.gz https://github.com/Ensembl/Bio-DB-HTS/archive/${VERSION}.tar.gz
rm -rf distro/*
tar --strip-components 1 -C distro -zxf distro.tar.gz
cd distro
perl Build.PL --install_base=$OPT --htslib=$OPT
./Build
./Build test
./Build install
