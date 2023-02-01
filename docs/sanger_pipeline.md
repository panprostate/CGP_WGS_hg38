# Analysis

At the Sanger Institute, WGS analysis is performed by running containerised tools as singularity images. The order and flow of input/output s orchestrated by 'bpipe' - a perl based pipeline manager.

The containerised tools are available to be downloaded individually as singularity or docker images.

| Tool | Entry Command |
| --- | --- |
| [BRASS Link](https://quay.io/repository/wtsicgp/brass)  | brass.pl |
| [ascatNGS](https://quay.io/repository/wtsicgp/ascatngs) | ascat.pl |
| [cgpcavemanwrapper](https://quay.io/repository/wtsicgp/cgpcavemanwrapper) | caveman.pl |
| [cgppindel](https://quay.io/repository/wtsicgp/cgppindel) | pindel.pl |

However, all of the tools are contained together in a single container '[dockstore-cgpwgs](https://github.com/cancerit/dockstore-cgpwgs)'. All of the tools can be run at once on a tumor normal pair using this image. This is controlled by the script [analysisWGS.sh]('https://github.com/cancerit/dockstore-cgpwgs/blob/develop/scripts/analysisWGS.sh') (which is called using the entry point 'ds-cgpwgs.pl').

## Reference data

The hg38 reference files are hosted on the sanger ftp site.

```bash
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/CNV_SV_ref_GRCh38_hla_decoy_ebv_brass6+.tar.gz
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/core_ref_GRCh38_hla_decoy_ebv.tar.gz
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/qcGenotype_GRCh38_hla_decoy_ebv.tar.gz
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/README.md
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/SNV_INDEL_ref_GRCh38_hla_decoy_ebv-fragment.tar.gz
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/VAGrENT_ref_GRCh38_hla_decoy_ebv_ensembl_91.tar.gz
```

The contents of these archives should be extracted into a common directory.

## Running under docker

The following is an example of the run command for docker.  It assumes the `-v` locations exist:

```bash
docker run  \
	-v ${WORKSPACE_DIR}/workspace:/workspace:rw \
	-v ${REF_DIR}/data:/data:ro \
	-v ${DATA_DIR}/ref:/ref:ro \
	quay.io/wtsicgp/dockstore-cgpwgs:$CGPWGS_VERSION \
	ds-cgpwgs.pl \
		-r ${REF_DIR} \
		-a ${REF_DIR} \
		-si ${REF_DIR} \
		-cs ${REF_DIR} \
		-qc ${REF_DIR} \
		-t ${TUMOR_BAM} \
		-tidx ${TUMOR_BAM}.bai \
		-n ${TUMOR_BAM} \
		-nidx ${NORMAL_BAM}.bai \
		-o /workspace;
```
