FROM ubuntu:22.04

RUN apt update && apt install -y curl

WORKDIR /maze

COPY mazerunner.bash ./client/

RUN chmod +x ./client/*.bash