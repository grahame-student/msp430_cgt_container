FROM ubuntu:18.04

# Add Code Composer Studio
ENV INSTALLER_URL=https://software-dl.ti.com/codegen/esd/cgt_public_sw/MSP430/21.6.0.LTS/ti_cgt_msp430_21.6.0.LTS_linux-x64_installer.bin

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends apt-utils=1.6.14 \
                                                  autoconf=2.69-11 \
                                                  libtool=2.4.6-2 \
                                                  build-essential=12.4ubuntu1 \
                                                  libc6-i386=2.27-3ubuntu1.6 \
                                                  libgconf-2-4=3.2.6-4ubuntu1 \
                                                  software-properties-common=0.96.24.32.18 \
                                                  curl=7.58.0-2ubuntu3.19 \
                                                  unzip=6.0-21ubuntu1.1 \
                                                  wget=1.19.4-1ubuntu2.2 && \
    apt-get clean && \
    rm -rf /etc/apt/*

WORKDIR /ccs_install
RUN wget -q ${INSTALLER_URL} \
    && chmod 777 /ccs_install/${INSTALLER_URL} \
    && ls -l /ccs_install \
    && ${INSTALLER_URL} --prefix /opt/ti --unattendedmodeui minimal \
    && rm -rf /ccs_install/
