###############
# BUILD VEROVIO
###############

FROM buildpack-deps:jessie-scm AS build-env

ARG VEROVIO_VERSION=1.1.6

WORKDIR /usr
RUN apt-get update && apt-get install -y git cmake build-essential && git clone https://github.com/rism-ch/verovio.git && cd verovio && git checkout tags/version-$VEROVIO_VERSION -b version-$VEROVIO_VERSION
WORKDIR /usr/verovio/tools
RUN cmake . && make && make install/strip

#############
# FINAL IMAGE
#############

FROM adorsys/openjdk-jre-base:8-minideb

COPY --from=build-env /usr/local/bin/verovio /usr/local/bin/verovio
COPY --from=build-env /usr/local/share/verovio /usr/local/share/verovio


