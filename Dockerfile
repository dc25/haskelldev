FROM ubuntu:16.10

# Set the locale - was (and may still be ) necessary for ghcjs-boot to work
# Got this originally here: # http://askubuntu.com/questions/581458/how-to-configure-locales-to-unicode-in-a-docker-ubuntu-14-04-container
#
# 2015-10-25 It seems like ghcjs-boot works without this now but when I 
# removed it, vim starting emitting error messages when using plugins 
# pathogen and vim2hs together.  
#
# 2016-07-11 Tried taking it out again.
# 2016-07-11 Did not notice problems with vim but saw errors reported that 
#            were not there before when running ./try-reflex . Leaving in.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt-get update && apt-get install -y \
    bzip2 \
    cpio \
    curl \
    daemontools \
    entr \
    git \
    net-tools \
    openssh-server \
    python \
    tmux \
    sudo \
    vim-gtk 

RUN apt-get update && apt-get install -y \
    g++ \
    make \
    nodejs-legacy \
    npm \
    ruby \
    ruby-dev

WORKDIR /tmp
COPY build_scripts/setup_sshd .
RUN ./setup_sshd

ARG user
ARG id
ARG key

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --home /workarea --uid $id $user 
RUN adduser $user sudo 

WORKDIR /workarea

# copy bash config scripts now in case later installs modify them
COPY build_scripts/.profile .
COPY build_scripts/.bashrc .
RUN chown -R ${user} .

COPY build_scripts/setup_basic_vim_plugins .
RUN su ${user} -c ./setup_basic_vim_plugins

# COPY build_scripts/user_installs.sh .
# RUN su ${user} -c ./user_installs.sh

COPY build_scripts/personalize.sh .
RUN su ${user} -c ./personalize.sh

USER ${user}
RUN mkdir .ssh
RUN echo ${key} | tee .ssh/authorized_keys > /dev/null
RUN chmod 600 .ssh/authorized_keys

# COPY build_scripts/myVimrc .
COPY build_scripts/start.sh .
COPY build_scripts/.tmux.conf .
COPY build_scripts/.vimrc .

RUN sudo chown -R ${user} .

COPY build_scripts/Gemfile .
COPY build_scripts/install_bundler .
RUN ./install_bundler

