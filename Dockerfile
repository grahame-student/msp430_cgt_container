FROM ubuntu:18.04

# Add Code Composer Studio
ENV INSTALLER_URL=https://software-dl.ti.com/codegen/esd/cgt_public_sw/MSP430/21.6.0.LTS/ti_cgt_msp430_21.6.0.LTS_linux-x64_installer.bin

RUN cd /ccs_install \
    && wget -q ${INSTALLER_URL} \
    && chmod 777 /ccs_install/${INSTALLER_URL} \
    && ls -l /ccs_install \
    && ${INSTALLER_URL} --prefix /opt/ti --unattendedmodeui minimal \
    && rm -rf /ccs_install/
    
