FROM ubuntu:22.04

RUN apt update && \
    apt -y install nano \
    cowsay \
    fortune \
    bsdmainutils

WORKDIR script

COPY script/ .

RUN chmod +x ./*.bash

ENTRYPOINT ["/bin/bash", "-c", "./commands.bash all"]