FROM ubuntu:18.04
# using 18.04 for now because I couldn't build 
# https://github.com/portstrom/fetch_mediawiki_configuration with 18.10

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

COPY build_scripts/install_neovim.sh /tmp
RUN su ${user} -c /tmp/install_neovim.sh

COPY build_scripts/install_latest_vim.sh /tmp
RUN /tmp/install_latest_vim.sh

COPY build_scripts/sshdVimrc /tmp
RUN su ${user} -c 'cp /tmp/sshdVimrc ~'
RUN su ${user} -c "echo so ~/sshdVimrc | tee -a ~/vimrc"

