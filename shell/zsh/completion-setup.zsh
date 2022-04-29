# Setup zsh completion style
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# Setup completion for some commands
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:pkexec:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:root:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Setup advanced completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=** l:|=*'
zstyle :compinstall filename '/home/neo/.zshrc1'

# Setup completion
autoload -U compinit
compinit

# Setup automatic correction
setopt correctall
