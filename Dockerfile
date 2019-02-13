FROM ubuntu:18.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    daemontools \
    language-pack-en-base \
    net-tools \
    openssh-server \
    tmux \
    sudo 

WORKDIR /tmp
COPY build_scripts/setup_sshd .
RUN ./setup_sshd

COPY build_scripts/start.sh  /

ARG user
ARG id

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --uid $id $user 
RUN adduser $user sudo 

COPY build_scripts/tmux.conf  .
RUN su $user -c "cp /tmp/tmux.conf ~/.tmux.conf"

COPY build_scripts/vimrc  .
RUN su $user -c "cp /tmp/vimrc ~/.vimrc"
