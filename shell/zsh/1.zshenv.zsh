# Environnement variables and setup variables for zsh
# Setup the antigen installation directory
# export _ANTIGEN_INSTALL_DIR=/home/neo/.antigen
# export _ANTIGEN_INSTALL_DIR=/usr/share/zsh/share
# Setup the antigen log directory
# export ANTIGEN_DEBUG_LOG=/tmp/antigen.log
# Setup the path to the oh-my-zsh installation directory
export ZSH=$HOME/.antigen/bundles/robbyrussell/oh-my-zsh
# Ignore alias for _ and gksu
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_"
# Setup the history
export HISTFILE=~/.zsh_history
export HISTSIZE=5000000000000000000
export SAVEHIST=5000000000000000000
# Setup the path
export PATH="/home/neo/Programes:/home/neo/Documents/Python:$PATH"