FROM ubuntu:vivid

RUN mkdir /workarea
WORKDIR /workarea

# Set the locale - was (and may still be ) necessary for ghcjs-boot to work
## RUN locale-gen en_US.UTF-8  
## ENV LANG en_US.UTF-8  
## ENV LANGUAGE en_US:en  
## ENV LC_ALL en_US.UTF-8  

##################################
##### Quick and minimal set ######
##### of developer's tools. ######
##################################
ADD setup_bash_startup /workarea/
RUN ./setup_bash_startup 

ADD install_devl_tools /workarea/
RUN ./install_devl_tools 

ADD setup_sshd /workarea/
RUN ./setup_sshd 

EXPOSE 22
EXPOSE 8000
ENTRYPOINT ["/usr/bin/svscan", "/services/"]

##################################
##### Install jekyll #############
##################################
ADD install_jekyll_prerequisites /workarea/
RUN ./install_jekyll_prerequisites 

ADD install_jekyll_and_friends /workarea/
RUN ./install_jekyll_and_friends

###########################################
#####    Personal Customization       #####
###########################################
ADD personalize /workarea/
RUN ./personalize
