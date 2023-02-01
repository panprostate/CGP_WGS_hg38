# Mapping

[dockstore-cgpmap](https://github.com/cancerit/dockstore-cgpmap) is a containerised tool written by the Sanger institute to peform mapping with bwamem or bwamem2 and post mapping alignment using bwakit.

## Running with helper script (Docker or Singularity)

The helper script [cgpmap_helper.sh](../scripts/cgpmap_helper.sh) will download and extract the necessary reference files, and then run the pipeline either with docker or singularity.

```bash
bash cgpmap_helper.sh [BAM_FILE] [HOW] [BWAMEM]
```

| Argument      | Description                                                      |
| ---           | ---                                                              |
| BAM_FILE      | Either a single bam file or a comma-seperated list of bam files. |
| HOW           | 'singularity' or 'docker'                                        |
| BWAMEM        | '1' or '2' (bwamem or bwamem2)                                   |

There are some variables in the script that should be changed if necessary.

| Variable      | Description                                  |
| ---           | ---                                          |
| DATA_DIR      | Directory containing the .bam and .bai files |
| REF_DIR       | Directory to keep reference files            |
| WORKSPACE_DIR | Workspace and output directory               |
| CPU           | Threads                                      |

## Downloading reference files

The hg38 reference files are hosted on the sanger ftp site.

```bash
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/bwa_idx_GRCh38_hla_decoy_ebv_bwamem2.tar.gz
ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/core_ref_GRCh38_hla_decoy_ebv.tar.gz
```

The contents of these archives should be extracted into a common directory.

## Running under singularity

*Note: cgpmap has been tested to work with singularity version 3.8.7 only*

```bash
singularity pull docker://quay.io/wtsicgp/dockstore-cgpmap:3.3.0;
singularity exec \
	--bind ${REF_DIR}:/ref:ro \
	--bind ${DATA_DIR}:/data:ro \
	--home ${WORKSPACE_DIR}:/workspace \
	--workdir /workspace \
	dockstore-cgpmap_3.3.0.sif \
		ds-cgpmap.pl \
			-r /ref \
			-i /ref \
			-o /workspace \
			-s ${NAME} \
			-t ${CPU} \
			-bwakit;
```

## Running under docker

```bash
docker pull quay.io/wtsicgp/dockstore-cgpmap:3.3.0;
docker run \
	-v ${REF_DIR}/data:/data:ro \
	-v ${DATA_DIR}/ref:/ref:ro \
	-v ${WORKSPACE_DIR}/workspace:/workspace:rw \
	quay.io/wtsicgp/dockstore-cgpmap:${CGPMAP_VER} \
		ds-cgpmap.pl \
			-r /ref \
			-i /ref \
			-o /workspace \
			-s ${NAME} \
			-t ${CPU} \
			-bwakit;
```

## Output
