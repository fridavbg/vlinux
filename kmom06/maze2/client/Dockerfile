FROM ubuntu:22.04

RUN apt update && apt install -y curl

WORKDIR /maze2/client/

COPY mazerunner.bash ./

RUN chmod +x ./*.bash
