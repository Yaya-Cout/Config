# Remove pip3 alias if exists
if alias | grep "pip3=" >/dev/null; then
  unalias pip3
fi
# Initialise pip search
pip3_classic="$(command -v pip3)"
function _pip3(){
    # If pip search is asked, run pip search
    if [[ $1 = "search" ]]; then
        pip_search "$2"
    # Else run pip normally
    else
        ${pip3_classic} "$@"
    fi
}
alias pip3='_pip3'
# Initialise guest account function (depend of lightdm)
guest (){
    account=$(sudo guest-account add)
    cp ~/.Xauthority /tmp/.Xauthority
    sudo su "${account}"
    sudo guest-account remove "${account}"
}
# Build micro:bit project with pxt
microbit (){
    oldpwd=${PWD}
    cd /home/neo/Documents/Micro:bit/build || return
    pxt install
    pxt deploy
    cd "${oldpwd}" || return
}
# Build javascript micro:bit project with pxt
microbitjs (){
    rm -f /home/neo/Documents/Micro:bit/build/main.ts
    ln "$1" /home/neo/Documents/Micro:bit/build/main.ts
    rm -f /home/neo/Documents/Micro:bit/build/pxt.json
    ln /home/neo/Documents/Micro:bit/build/pxt.js.json /home/neo/Documents/Micro:bit/build/pxt.json
    microbit "$@"
}
# Build python micro:bit project with pxt
microbitpy (){
    rm -f /home/neo/Documents/Micro:bit/build/main.py
    ln "$1" /home/neo/Documents/Micro:bit/build/main.py
    rm -f /home/neo/Documents/Micro:bit/build/pxt.json
    ln /home/neo/Documents/Micro:bit/build/pxt.py.json /home/neo/Documents/Micro:bit/build/pxt.json
    microbit "$@"
}
# Lint a python file with most possibles linters
lint (){
    pylint "$@"
    flake8 "$@"
    mypy --ignore-missing-imports "$@"
    pylama "$@"
    # pyright "$@"
    # pylava "$@"
    pycodestyle "$@"
    pyflakes "$@"
    # coala "$@"
    # yapf "$@" # Is a formatter
    # autopep8 "$@" # Is a formatter
    # pyre "$@"
    vulture "$@"
    prospector -F -s veryhigh -m "$@"
    # sort "$@" # Is a formatter
    # bandit "$@"
    # eradicate "$@" # Is a formatter
    # radon hal "$@" # Only info
    # radon raw "$@" # Only info
    # radon mi "$@"# Only info
    pydocstyle "$@"
}
# Format a Python file
format (){
    black "$@"
}
# Clean file system to free space
clean (){
    sudo docker system prune -a -f
    sudo apt-get autoremove -y
    sudo aptitude purge "~c"
    sudo apt-get autoclean
    sudo apt-get clean
    flatpak uninstall --unused -y
    sudo sh -c "sudo rm /var/lib/snapd/snapshots/*"
    sudo rm /var/lib/snapd/seed/snaps/* 
    rm -fr ~/.cache/thumbnails/*
    rm -fr ~/.npm/_cacache/
    #rm -fr ~/Télécargements/Youtube/*
    rm **/.mypy_cache -rf
    #rm -fr **/node_modules
    # rm -fr ~/.config/Code/User/workspaceStorage/
    sudo /home/neo/Programes/remove-old-snaps.sh
    trash-empty
    sudo journalctl --vacuum-time=3d
    # czkawka_auto &
    sudo -E bleachbit
    # flatpak run com.github.qarmin.czkawka
    baobab
    # sudo journalctl --vacuum-time=3d
    wait
}
# Free space on disk with possibly damaged files
cleanhard () {
    czkawka_auto &
    clean
    wait
}
# Remove broken files, empty directories and link duplicates files
czkawka_auto (){
    czkawka_cli dup --directories /home/neo -D hard -e /home/neo/Musique
    czkawka_cli broken --directories /home/neo -e /home/neo/Musique -D
    czkawka_cli empty-files --directories /home/neo -e /home/neo/Musique -D
    czkawka_cli empty-folders --directories /home/neo -e /home/neo/Musique -D
    czkawka_cli symlinks --directories /home/neo -e /home/neo/Musique -D
}
# Create a new zRAM swap file
swapadd () {
    zramswappath=$(sudo zramctl --find --size "$@")
    sudo mkswap "${zramswappath}"
    sudo swapon -p 4 "${zramswappath}"
}
# Create a EXT4 filesystem on zRAM
ramext4 () {
    zramdiskpath=$(sudo zramctl --find --size "$@")
    sudo mkfs.ext4 "${zramdiskpath}"
    sudo mount "${zramdiskpath}" /mnt
    sudo chmod -R 777 /mnt
}
# Setup and chroot a disk
chroot-conf () {
    sudo mount "$1" /mnt
    sudo mount -o bind /dev /mnt/dev
    sudo mount -o bind /sys /mnt/sys
    sudo mount -t proc /proc /mnt/proc
    sudo mount -o bind /run /mnt/run
    # sudo cp /proc/mounts /mnt/etc/mtab
    sudo chroot /mnt /bin/bash
    sudo umount /mnt/dev
    sudo umount /mnt/sys
    sudo umount /mnt/proc
    sudo umount /mnt/run
    sudo mount "$1" /mnt
}
# Setup screen colors
colorset () {
    gamma="1:0.81:0.41"
    brightness=1
    outputs=( "eDP1" "DP1" "HDMI1" "HDMI2" "VIRTUAL1" "VIRTUAL2" )
    for target in "${outputs[@]}"
    do
            xrandr --screen 0 --output "${target}" --brightness "${brightness}" --gamma "${gamma}" "$@"
    done
}
# Show a QR code on the terminal
qrcode () {
    local input="$*"
    [[ -z "${input}" ]] && local input="@/dev/stdin"
    curl -d "${input}" https://qrcode.show
}

# Export a QR code to a svg file
qrsvg () {
    local input="$*"
    [[ -z "$input" ]] && local input="@/dev/stdin"
    curl -d "${input}" https://qrcode.show -H "Accept: image/svg+xml"
}

# Serve a local directory with a QR code
qrserve () {
    local port=${1:-8080}
    local dir=${2:-.}
    local ip="$(ifconfig | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | fzf --prompt IP:)" \
    && echo "http://${ip}:${port}" | qrcode \
    && python -m http.server "${port}" -b "${ip}" -d "${dir}"
}

# Wait for a site to be available
wait_site_work () {
    while true
    do
        output="$(curl --write-out "%{http_code}\n" --output /dev/stderr $@ --silent)"
        if [[ ${output} -eq 200 ]]
        then
            cvlc --play-and-exit /usr/share/sounds/ubuntu/notifications/Positive.ogg
        fi
        echo ""
        sleep 10
    done
}

# Use fzf to select a directory and cd into it (without ./ prefix)
cd2 () {
    local dir
    # Get if a directory is given as argument
    if [[ -d "$1" ]]
    then
        dir="$1"
    else
        dir="./"
    fi
    dir="$(find . -type d -not -path '*/\.*' -not -path '*/node_modules' 2>/dev/null | fzf --prompt 'cd ' --exit-0)"
    [[ -n "${dir}" ]] && builtin cd "${dir}" || return 1
}

# # Use fzf to select a directory and cd into it (without ./ prefix)
# # It uses z to find the most used directories
# a () {
#     local dir
#     # If arguments are given, rebind to z
#     if [[ -n "$@" ]]
#     then
#         z "$@"
#         return
#     fi
#     # dir="$(z -l | fzf --prompt 'cd ' --exit-0 --tac)"
#     # We want to use z and find commands in parallel while fzf is waiting for
#     # input
#     dir="$(z -l & find . -type d -not -path '*/\.*' -not -path '*/node_modules' 2>/dev/null | fzf --prompt 'cd ' --exit-0 --tac)"

#     # Return if the directory doesn't exist
#     [[ -z "${dir}" ]] && return 1
#     # Get the directory from the z output (we support directories with spaces)
#     dir="$(echo "${dir}" | cut -d ' ' -f 2-)"
#     # Remove spaces at the start of the directory (because of z)
#     dir="$(echo "${dir}" | sed 's/^ *//')"
#     [[ -n "${dir}" ]] && builtin cd "${dir}" || return 1
#     # [[ -n "${dir}" ]] && builtin cd "${dir}" || return 1
# }
