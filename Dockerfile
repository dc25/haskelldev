FROM ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    net-tools \
    openssh-server \
    sudo \
    tmux 

RUN echo "X11UseLocalhost no" | tee -a /etc/ssh/sshd_config

COPY start.sh  /

ARG user
ARG id
ARG key

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --uid $id $user 
RUN adduser $user sudo 

USER $user

RUN mkdir -p ~/.ssh
RUN echo $key > ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys

COPY tmux.conf  /tmp
RUN cp /tmp/tmux.conf ~/.tmux.conf

# ---------------------------------------------------------

COPY install_vscode.sh /tmp
RUN /tmp/install_vscode.sh

COPY install_stack.sh /tmp
RUN /tmp/install_stack.sh

COPY install_hie_wrapper.sh /tmp
RUN /tmp/install_hie_wrapper.sh

COPY install_vscode_haskell_debugger.sh /tmp
RUN /tmp/install_vscode_haskell_debugger.sh 

COPY myBashrc /tmp
RUN cp /tmp/myBashrc ~
RUN echo . ~/myBashrc | tee -a ~/.bashrc

