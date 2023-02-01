FROM ubuntu:20.04 as builder

USER root
ENV OPT /opt
ENV BIN ${OPT}/bin
ENV BUILD /build
ENV TEMP ${BUILD}/temp
ENV LOGS ${BUILD}/logs
ENV LD_LIBRARY_PATH $OPT/lib
RUN mkdir -p ${OPT} ${BIN} ${BUILD} ${TEMP} ${LOGS} ${LD_LIBRARY_PATH}

ENV PATH ${BIN}:$PATH
ENV LC_ALL C

RUN apt-get -yq update
RUN apt-get install -yq --no-install-recommends build-essential
RUN apt-get install -yq --no-install-recommends apt-transport-https
RUN apt-get install -yq --no-install-recommends curl
RUN apt-get install -yq --no-install-recommends ca-certificates
RUN apt-get install -yq --no-install-recommends make
RUN apt-get install -yq --no-install-recommends bzip2
RUN apt-get install -yq --no-install-recommends gcc
RUN apt-get install -yq --no-install-recommends libtasn1-dev
RUN apt-get install -yq --no-install-recommends nettle-dev
RUN apt-get install -yq --no-install-recommends libgmp-dev
RUN apt-get install -yq --no-install-recommends libp11-kit-dev
RUN apt-get install -yq --no-install-recommends zlib1g-dev
RUN apt-get install -yq --no-install-recommends libbz2-dev
RUN apt-get install -yq --no-install-recommends liblzma-dev
RUN apt-get install -yq --no-install-recommends libcurl4-gnutls-dev
RUN apt-get install -yq --no-install-recommends libncurses5-dev
RUN apt-get install -yq --no-install-recommends libgnutls28-dev
RUN apt-get install -yq --no-install-recommends file

ADD build/install.sh ${BUILD}/

ADD build/libdeflate.sh ${BUILD}/
RUN bash ${BUILD}/install.sh libdeflate v1.6
ADD build/htslib.sh ${BUILD}/
RUN bash ${BUILD}/install.sh htslib 1.12
ADD build/libBigWig.sh ${BUILD}/
RUN bash ${BUILD}/install.sh libBigWig 0.4.6
ADD build/cgpBigWig.sh ${BUILD}/
RUN bash ${BUILD}/install.sh cgpBigWig 1.5.2

ADD build/k8.sh ${BUILD}/
RUN bash ${BUILD}/install.sh k8 0.2.5
ADD build/bwakit.sh ${BUILD}/
RUN bash ${BUILD}/install.sh bwakit v0.7.17
ADD build/biobam2.sh ${BUILD}/
RUN bash ${BUILD}/install.sh biobam2
ADD build/cpanm.sh ${BUILD}/
RUN bash ${BUILD}/install.sh cpanm
ADD build/scramble.sh ${BUILD}/
RUN bash ${BUILD}/install.sh scramble
ADD build/samtools.sh ${BUILD}/
RUN bash ${BUILD}/install.sh samtools 1.12
ADD build/bwa.sh ${BUILD}/
RUN bash ${BUILD}/install.sh bwa v0.7.17
ADD build/bwa2.sh ${BUILD}/
RUN bash ${BUILD}/install.sh bwa2 v2.2.1
ADD build/bio-db-hts.sh ${BUILD}/
RUN bash ${BUILD}/install.sh bio-db-hts v2.2.1
