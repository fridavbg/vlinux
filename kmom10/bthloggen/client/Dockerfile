FROM ubuntu:22.04

RUN apt update && apt install -y curl

WORKDIR /bthloggen/client/

COPY bthloggen.bash ./

RUN chmod +x ./*.bash
