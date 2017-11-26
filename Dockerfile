FROM ubuntu:16.10

# Build as user ghc with "random" user id.
ENV USER_NAME builder
ENV USER_ID 54946

# Set the locale - not having this seems to cause problems.
# Got this here: # http://askubuntu.com/questions/581458/how-to-configure-locales-to-unicode-in-a-docker-ubuntu-14-04-container
#
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Create a new user, to do the rest of the build.
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

RUN adduser --disabled-password --gecos '' --uid $USER_ID $USER_NAME
RUN adduser $USER_NAME sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER $USER_NAME

ENV WORKAREA /home/$USER_NAME/workarea/
RUN mkdir -p $WORKAREA
WORKDIR $WORKAREA

COPY build_scripts/install_devl_tools $WORKAREA
RUN ./install_devl_tools 

ADD build_scripts/Gemfile $WORKAREA
RUN cp $WORKAREA/Gemfile $HOME
ADD build_scripts/install_bundler $WORKAREA
RUN ./install_bundler

COPY build_scripts/setup_sshd $WORKAREA
RUN ./setup_sshd 

COPY build_scripts $WORKAREA
RUN sudo cp start.sh /
