FROM ghcr.io/actions/actions-runner:latest

RUN sudo apt update -y && \
    sudo apt install -y \
    curl git gcc cmake make build-essential libmagic1 libmagic-dev