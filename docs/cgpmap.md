# Maping to hg38

Mapping is done using [dockstore-cgpmap](https://github.com/cancerit/dockstore-cgpmap).

The container can be run with Docker or Singularity, either manually or with the helper script.

## Running with helper script (Docker or Singularity)

The helper script [cgpmap_helper.sh](../scripts/cgpmap_helper.sh) should download the necessary reference files and then run the mapping pipeline with either docker or singularity.

```bash
bash cgpmap_helper.sh CGP00001.bam singularity 2
```

There are some variables that should be changed if necessary.

| Variable      | Description                                  |
| ---           | ---                                          |
| DATA_DIR      | Directory containing the .bam and .bai files |
| REF_DIR       | Directory to keep reference files            |
| WORKSPACE_DIR | Workspace and output directory               |
| CPU           | Threads                                      |

## Running manually under singularity

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

## Running manually under docker

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
