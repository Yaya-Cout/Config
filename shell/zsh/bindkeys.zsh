# Key bindings for zsh
# bindkey '^H' run-help

# Because VS Code doesn't use the same key codes as GNOME Terminal, we need to
# remap the keys to the same codes as GNOME Terminal.
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# Bind Ctrl+Backspace to delete the word before the cursor
bindkey '^H' backward-kill-word
# bindkey '^?' backward-kill-word

# Bind End and Home to jump to the beginning and end of the line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[5~' beginning-of-line
bindkey '^[[6~' end-of-line

# Suppr delete the character under the cursor
bindkey '^[[3~' delete-char
# Ctrl+Suppr delete the word after the cursor
bindkey '^[[3;5~' kill-word
