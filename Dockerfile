FROM vcatechnology/linux-mint

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

ARG user
ARG id

ENV DEVL $user

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --home /workarea --uid $id $DEVL 
RUN adduser $DEVL sudo 

WORKDIR /workarea

COPY build_scripts/.profile .
COPY build_scripts/.bashrc .
COPY build_scripts/start.sh .
COPY build_scripts/.tmux.conf .
COPY build_scripts/.vimrc .

RUN chown -R ${DEVL} .

COPY build_scripts/setup_basic_vim_plugins .
RUN su ${DEVL} -c ./setup_basic_vim_plugins

RUN su ${DEVL} -c  'git config --global user.email "davecompton7@gmail.com"'
RUN su ${DEVL} -c  'git config --global user.name "Dave Compton"'

