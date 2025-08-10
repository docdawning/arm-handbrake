# mostly written by GenAI, as is the order of things.
FROM automaticrippingmachine/automatic-ripping-machine:latest

USER root

RUN apt-get update && \
    apt-get install -y software-properties-common wget gnupg ca-certificates && \
    add-apt-repository multiverse && \
    apt-get update && \
    apt-get install -y handbrake-cli libdvdcss2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY rip_handbrake.sh /home/arm/scripts/rip_handbrake.sh
RUN chmod +x /home/arm/scripts/rip_handbrake.sh

