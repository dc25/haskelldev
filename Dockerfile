# went to 19.10 to get latest ruby
FROM ubuntu:19.10

# FROM ubuntu:16.04
# went back to 16.04 to get binary compatility for rust programs
# using 18.04 for now because I couldn't build 
# https://github.com/portstrom/fetch_mediawiki_configuration with 18.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    daemontools \
    language-pack-en-base \
    net-tools \
    openssh-server \
    sudo \
    tmux 

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

COPY build_scripts/install_latest_vim.sh /tmp
RUN /tmp/install_latest_vim.sh

COPY build_scripts/build_latest_neovim.sh /tmp
RUN /tmp/build_latest_neovim.sh

COPY build_scripts/setup_vimrc.sh /tmp
RUN su $user -c /tmp/setup_vimrc.sh

COPY build_scripts/setup_neovimrc.sh /tmp
RUN su $user -c /tmp/setup_neovimrc.sh

COPY build_scripts/sshdVimrc /tmp
RUN su ${user} -c 'cp /tmp/sshdVimrc ~'
RUN su ${user} -c "echo so ~/sshdVimrc | tee -a ~/vimrc"
