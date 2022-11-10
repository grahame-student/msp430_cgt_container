FROM ubuntu:22.04

# Add Code Composer Studio
ENV INSTALLER_URL=https://software-dl.ti.com/codegen/esd/cgt_public_sw/MSP430/21.6.0.LTS/ti_cgt_msp430_21.6.0.LTS_linux-x64_installer.bin

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends apt-utils \
                                                  autoconf \
                                                  libtool \
                                                  build-essential \
                                                  libc6-i386 \
                                                  libgconf-2-4 \
                                                  software-properties-common \
                                                  curl \
                                                  unzip \
                                                  wget && \
    apt-get clean && \
    rm -rf /etc/apt/*

WORKDIR /ccs_install
RUN wget -q ${INSTALLER_URL} \
    && chmod 777 /ccs_install/${INSTALLER_URL} \
    && ls -l /ccs_install \
    && ${INSTALLER_URL} --prefix /opt/ti --unattendedmodeui minimal \
    && rm -rf /ccs_install/
