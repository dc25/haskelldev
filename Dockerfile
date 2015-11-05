FROM ubuntu:vivid

ENV REBUILD=true

RUN mkdir /workarea
WORKDIR /workarea

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
##### Add jekyll related items  ##
##################################
ADD install_jekyll_prerequisites /workarea/
RUN ./install_jekyll_prerequisites 

ADD install_bundler /workarea/
RUN ./install_bundler

ADD setup_jekyll_aliases /workarea/
RUN ./setup_jekyll_aliases

##################################
##### Add some scripts          ##
##################################
ADD bin /root/bin

###########################################
#####    Personal Customization       #####
###########################################
ADD personalize /workarea/
RUN ./personalize
