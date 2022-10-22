FROM ubuntu:22.04

RUN apt update && apt install -y curl jq

WORKDIR /bthloggen/client/

COPY bthloggen.bash server.txt ./

RUN chmod +x ./*.bash
