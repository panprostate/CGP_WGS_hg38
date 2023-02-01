set -ex;


INSTALL=${1};
VERSION=${2};
export VERSION=${VERSION};

INSTALL_SCRIPT="${BUILD}/${INSTALL}.sh";
if [ ! -f ${INSTALL_SCRIPT} ]; then
  echo '${INSTALL_SCRIPT} not found.';
  exit 1;
fi;

CPU=$(grep -c ^processor /proc/cpuinfo);
if [ $? -eq 0 ]; then
  if [ "$CPU" -gt "6" ]; then
    CPU=6;
  fi;
else
  CPU=1;
fi;

export CPU=${CPU};

if [ ! -f "${LOGS}/${INSTALL}.done" ]; then
  mkdir -p ${TEMP}/${INSTALL};
  cd ${TEMP}/${INSTALL};
  echo ${INSTALL_SCRIPT};
  bash "${INSTALL_SCRIPT}";
  touch ${LOGS}/${INSTALL}.done;
fi;
