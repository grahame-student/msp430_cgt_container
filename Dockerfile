FROM ubuntu:22.04

# Add Code Composer Studio
ENV INSTALLER_VERSION=21.6.0.LTS
ENV INSTALLER_URL=https://software-dl.ti.com/codegen/esd/cgt_public_sw/MSP430/${21.6.0.LTS}/ti_cgt_msp430_${21.6.0.LTS}_linux-x64_installer.bin
ENV INSTALLER_NAME=ti_cgt_msp430_${21.6.0.LTS}_linux-x64_installer.bin

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

WORKDIR /ccs_install
RUN wget -q ${INSTALLER_URL}
RUN chmod 777 /ccs_install/${INSTALLER_NAME}
RUN ls -l /ccs_install
RUN ./${INSTALLER_NAME} --prefix /opt/ti --unattendedmodeui minimal
RUN rm -rf /ccs_install/
