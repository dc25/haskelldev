FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    bzip2 \
    cpio \
    curl \
    daemontools \
    entr \
    git \
    language-pack-en-base \
    net-tools \
    openssh-server \
    python \
    tmux \
    sudo \
    vim-gtk 

WORKDIR /tmp
COPY build_scripts/setup_sshd .
RUN ./setup_sshd

COPY build_scripts/start.sh  /

ARG user
ARG id

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --uid $id $user 
RUN adduser $user sudo 

RUN mkdir /tmp/build_scripts
COPY build_scripts/.profile  /tmp/build_scripts
COPY build_scripts/.bashrc  /tmp/build_scripts
COPY build_scripts/.tmux.conf  /tmp/build_scripts
COPY build_scripts/.vimrc  /tmp/build_scripts

RUN su $user -c "cp /tmp/build_scripts/{.profile,.bashrc,.tmux.conf,.vimrc} ~"
 
COPY build_scripts/setup_basic_vim_plugins  /tmp/build_scripts/
RUN su $user -c '/tmp/build_scripts/setup_basic_vim_plugins'
 
RUN su $user -c 'git config --global user.email "davecompton7@gmail.com"'
RUN su $user -c 'git config --global user.name "Dave Compton"'

