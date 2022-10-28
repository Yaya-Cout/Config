# Fix compinit: command not found error on antigen startup
autoload -U compinit
compinit

# Set ANTIDOTE_CONF_DIR to ${SHELLCONFPATH}/shell/zsh to avoid bugs with VSCode
export ANTIDOTE_CONF_DIR=${SHELLCONFPATH}/shell/zsh

# If ~/.cache/antidote does not exist but ${ANTIDOTE_CONF_DIR}/antidote_list.zsh
# does, then we need to remove the old file.
if [ ! -d ~/.cache/antidote ] && [ -f ${ANTIDOTE_CONF_DIR}/antidote_list.zsh ]; then
    echo "Removing old ${ANTIDOTE_CONF_DIR}/.zsh_plugins.zsh file"
    rm ${ANTIDOTE_CONF_DIR}/antidote_list.zsh
fi

# Source Antidote (AUR package: zsh-antidote)
source /usr/share/zsh-antidote/antidote.zsh

# Load Antidote plugins
antidote load "${SHELLCONFPATH}/shell/zsh/antidote_list.txt"

# Setup prompt for Antidote
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# Setup dynamic loading of ohmyzsh code (use for omz commands)
function omz() {
    # This function is simply a function that loads ohmyzsh as antidote plugin
    # and then runs the command that was passed to it. After the ohmyzsh is
    # loaded, this function is removed from the shell (overwritten with the
    # ohmyzsh command).
    eval $(antidote bundle ohmyzsh/ohmyzsh)

    # Call ohmyzsh command
    omz $@
}
