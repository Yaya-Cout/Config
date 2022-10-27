# Fix compinit: command not found error on antigen startup
autoload -U compinit

#source /usr/share/zsh-antigen/antigen.zsh
source /usr/share/zsh/share/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle rails
antigen bundle textmate
antigen bundle ruby
antigen bundle lighthouse
antigen bundle fasd
antigen bundle docker
antigen bundle kubectl
antigen bundle python
antigen bundle heroku
antigen bundle pip
antigen bundle lein

antigen bundle git
antigen bundle common-aliases
antigen bundle colorize
antigen bundle zsh-navigation-tools
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle z
antigen bundle npm
antigen bundle systemadmin

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle djui/alias-tips
antigen bundle Yaya-Cout/zsh-web
antigen bundle Yaya-Cout/zsh-a
antigen bundle zpm-zsh/ls
# antigen bundle sobolevn/wakatime-zsh-plugin

# Load the theme.
antigen theme romkatv/powerlevel10k
# source ~/.p10k.zsh

# Tell Antigen that you're done.
antigen apply

omz plugin load z
