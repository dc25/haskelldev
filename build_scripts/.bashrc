#This script gets called from .bashrc whenever a shell starts.
# Edit to suit your own tastes.

export PATH=\
$HOME/bin:\
$PATH

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v=vim
alias cdgnc='cd /repos/gitnc'
alias cdgit='cd /repos/git'

alias jserv='bundle exec jekyll serve -H 0.0.0.0 --baseurl ""'
alias bupd='bundle update'
