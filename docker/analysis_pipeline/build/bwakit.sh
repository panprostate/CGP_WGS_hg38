echo "#!$OPT/bin/k8" > $OPT/bin/bwa-postalt
curl -sSL https://raw.githubusercontent.com/lh3/bwa/${VERSION}/bwakit/bwa-postalt.js >> $OPT/bin/bwa-postalt
chmod ugo+x $OPT/bin/bwa-postalt
