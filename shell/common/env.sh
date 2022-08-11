# Set GTK theme on QT applications
export QT_QPA_PLATFORMTHEME=gtk2
# Setup the display
export DISPLAY=:0
# Enable all colors on terminal
export TERM=xterm-256color
# Initialise wakatime path
export ZSH_WAKATIME_BIN=/usr/local/bin/wakatime
# TODO: Find what is it
export DIALOG_SLEEP=4
# Initialise the path to the editor
export EDITOR=/usr/bin/nano
export VISUAL=${EDITOR}
# Set up the command path
export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}