#
# 'cgpmap' Helper Script
# ======================
# Script to map bam files to hg38 with sanger's 'cgpmap' tool (uses bwamem and
# bwakit post alignment). Requires either docker or singularity.
#
# Example commands
# ----------------
# Map to hg38 with singularity, using bwamem2:
# $ bash cgpmap.sh CGP00001.bam singularity 2
#
# Map to hg38 with docker (not using bwamem2):
# $ bash cgpmap.sh CGP00001.bam singularity 2
#

#
# Variables (change if needed)
#

DATA_DIR="${HOME}/data"; # Directory containing the .bam and .bai files
REF_DIR="${HOME}/ref"; # Directory to keep reference files
WORKSPACE_DIR="${HOME}/workspace"; # Workspace and output directory
CPU="8"; # Threads
CGPMAP_VER="3.3.0"; # cgpmap version (3.3.0 for bwakit)
MIN_SINGULARITY_VERSION="3.8.7";

set -eu;

#
# Arguments
#

BAM="${1}"; # Bam file name
HOW="${2}"; # "singularity" or "docker"
BWAMEM="${3}"; # "1" or "2" (2=use bwamem2)

DATA="$(realpath ${DATA_DIR})";
REF="$(realpath ${REF_DIR})";
WORKSPACE="$(realpath ${WORKSPACE_DIR})";
NAME="${BAM%.*}";

# Check docker or singulairity installed
if ! command -v ${HOW} &> /dev/null; then
	echo "${HOW} > could not be found";
	exit 1;
fi;

# Check sinngularity version
if [ "${HOW}" == "singularity" ]; then
	SINGULARIY_VERSION=$(singularity --version | sed -e 's/^.*\s\(\S*\)$/\1/g');
	SMALLEST=$(echo -e "${SINGULARIY_VERSION}\n${MIN_SINGULARITY_VERSION}" | sort -V | head -n 1);
	if [ "${SMALLEST}" != "${MIN_SINGULARITY_VERSION}" ]; then
		echo "not tested to work below singularity version ${MIN_SINGULARITY_VERSION}";
		exit 1;
	fi;
fi;

# Check files and direcotories exist
mkdir -p ${DATA};
for FILE in \
	"${DATA}/${BAM}" \
	"${DATA}/${BAM}.bai" \
	; do \
	if [ ! -f "${FILE}" ]; then
		echo "${FILE} not found.";
		exit 1;
	fi;
done;

# Check/ get reference files
mkdir -p ${REF};
if [ ! -f "${REF}/genome.fa.ann" ]; then
	TAR="bwa_idx_GRCh38_hla_decoy_ebv_bwamem2.tar.gz";
	if [ ! -f "${REF}/${TAR}" ]; then
		wget -P ${REF} ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/${TAR};
	fi;
	tar -xzvf "${REF}/${TAR}" --strip-components=1;

if [ ! -f "${REF}/genome.fa" ]; then
	TAR="core_ref_GRCh38_hla_decoy_ebv.tar.gz";
	if [ ! -f "${REF}/${TAR}" ]; then
		wget -P ${REF} ftp://ftp.sanger.ac.uk/pub/cancer/dockstore/human/GRCh38_hla_decoy_ebv/${TAR};
	fi;
	tar -xzvf "${REF}/${TAR}" --strip-components=1;
fi;

mkdir -p ${WORKSPACE};

# Build command
COMMAND="ds-cgpmap.pl \
	-r /ref \
	-i /ref \
	-o /workspace \
	-s \"${NAME}\" \
	-t ${CPU} \
	-bwakit"
if [ "${BWAMEM}" == "2" ]; then
	COMMAND="${COMMAND} \
		-bm2"
fi;
COMMAND="${COMMAND} \
	\"/data/${BAM}\";"

if [ "${HOW}" == "docker" ]; then
	COMMAND="\
	docker pull quay.io/wtsicgp/dockstore-cgpmap:3.3.0;
	docker run \
		-v ${HOME}/data:/data:ro \
		-v ${HOME}/ref:/ref:ro \
		-v ${HOME}/workspace:/workspace:rw \
		quay.io/wtsicgp/dockstore-cgpmap:${CGPMAP_VER} \
			${COMMAND}";
fi;

if [ "${HOW}" == "singularity" ]; then
	COMMAND="\
	if [ ! -f dockstore-cgpmap_${CGPMAP_VER}.sif ]; then \
		singularity pull docker://quay.io/wtsicgp/dockstore-cgpmap:${CGPMAP_VER}; \
	fi; \
	singularity exec \
		--bind ${HOME}/ref:/ref:ro \
		--bind ${HOME}/data:/data:ro \
		--home ${HOME}/workspace:/workspace \
		--workdir /workspace \
		dockstore-cgpmap_${CGPMAP_VER}.sif \
			${COMMAND}"
fi;

#
# Execute command
#

bash -c "${COMMAND}";
