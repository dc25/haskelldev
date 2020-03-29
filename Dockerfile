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

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
RUN adduser --disabled-password --gecos '' --uid $id $user 
RUN adduser $user sudo 

COPY tmux.conf  /tmp
RUN su $user -c "cp /tmp/tmux.conf ~/.tmux.conf"

# ---------------------------------------------------------

COPY install_vscode.sh /tmp
RUN /tmp/install_vscode.sh

COPY install_stack.sh /tmp
RUN su ${user} -c /tmp/install_stack.sh

COPY install_hie_wrapper.sh /tmp
RUN su ${user} -c /tmp/install_hie_wrapper.sh

COPY install_vscode_haskell_debugger.sh /tmp
RUN su ${user} -c /tmp/install_vscode_haskell_debugger.sh 

COPY myBashrc /tmp
RUN su ${user} -c 'cp /tmp/myBashrc ~'
RUN su ${user} -c 'echo . ~/myBashrc | tee -a ~/.bashrc'

