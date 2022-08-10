source /usr/share/zsh/scripts/zplug/init.zsh

# Load the oh-my-zsh's plugins.
zplug "plugins/rails",   from:oh-my-zsh
zplug "plugins/textmate", from:oh-my-zsh
zplug "plugins/ruby",     from:oh-my-zsh
zplug "plugins/lighthouse", from:oh-my-zsh
zplug "plugins/fasd",     from:oh-my-zsh
zplug "plugins/docker",   from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/python",   from:oh-my-zsh
zplug "plugins/heroku",  from:oh-my-zsh
zplug "plugins/pip",     from:oh-my-zsh
zplug "plugins/lein",    from:oh-my-zsh


zplug "plugins/git",    from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/zsh-navigation-tools", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/z",      from:oh-my-zsh
zplug "plugins/npm",    from:oh-my-zsh
zplug "plugins/systemadmin",    from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "djui/alias-tips"
zplug "Yaya-Cout/zsh-web"
zplug "zpm-zsh/ls"

# Load the theme.
zplug "romkatv/powerlevel10k", as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
