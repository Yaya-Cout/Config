# Fix compinit: command not found error on antigen startup
autoload -U compinit
compinit

# If ~/.cache/anitdote does not exist but ~/.zsh_plugins.zsh does, then
# we need to remove the old file.
if [ ! -d ~/.cache/antidote ] && [ -f ~/.zsh_plugins.zsh ]; then
    echo "Removing old ~/.zsh_plugins.zsh file"
    rm ~/.zsh_plugins.zsh
fi

# Source Antidote (AUR package:zsh-antidote
# source /usr/share/zsh-antidote/antidote.zsh
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Load Antidote plugins
# antidote load "${SHELLCONFPATH}/shell/zsh/antidote_list.txt"
antidote load

# Setup prompt for Antidote
autoload -Uz promptinit && promptinit && prompt powerlevel10k
