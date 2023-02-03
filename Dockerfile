FROM ubuntu:23.04


# Prepare system and install dependencies
RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends apt-utils=2.4.8 \
                                                  autoconf=2.71-2 \
                                                  libtool=2.4.6-15build2 \
                                                  build-essential=12.9ubuntu3 \
                                                  libc6-i386=2.35-0ubuntu3.1 \
                                                  libgconf-2-4=3.2.6-7ubuntu2 \
                                                  software-properties-common=0.99.22.3 \
                                                  curl=7.81.0-1ubuntu1.6 \
                                                  unzip=6.0-26ubuntu3.1 \
                                                  wget=1.21.2-2ubuntu1 && \
    apt-get clean && \
    rm -rf /etc/apt/*


# Install MSP430 Code Generation Tools
ENV INSTALLER_VERSION=21.6.0.LTS
ENV INSTALLER_URL=https://software-dl.ti.com/codegen/esd/cgt_public_sw/MSP430/${INSTALLER_VERSION}/ti_cgt_msp430_${INSTALLER_VERSION}_linux-x64_installer.bin
ENV INSTALLER_NAME=ti_cgt_msp430_${INSTALLER_VERSION}_linux-x64_installer.bin

WORKDIR /ccs_install
RUN wget -q ${INSTALLER_URL} && \
    chmod 777 /ccs_install/${INSTALLER_NAME} && \
    ls -l /ccs_install && \
    ./${INSTALLER_NAME} --prefix /opt/ti --unattendedmodeui minimal && \
    rm -rf /ccs_install/
