# Setup Firefox Nightly
alias firefox="/home/neo/Téléchargements/firefox-nightly/firefox"
# Setup ripgrep alias
alias ripgrep="rg"
# Setup make to build with the maximum parallelism available
alias make="make -j"
# Initialise ipv4on / ipv4off commands
alias ipv4off="sudo ip address del 192.168.1.41/24 dev wlp0s20f3 && sudo ip address del 192.168.1.43/24 dev enp1s0"
alias ipv4on="sudo ip address add 192.168.1.41/24 dev wlp0s20f3 && sudo ip address add 192.168.1.43/24 dev enp1s0 && sudo systemctl restart 'NetworkManager*'"
# Setup scan alias to run clamdscan
alias scan="clamdscan --multiscan --fdpass"
# Setup whowns / whatown alias
alias whowns="pkgfile"
alias whatown="pkgfile -l"
# Setup apt-dump alias to list all manually installed packages
alias apt-dump="apt-mark showmanual"
# Create debsums-usable alias to run debsums with a usable output
alias debsums-usable="sudo debsums -as 2>&1 | grep -v locale | grep -v help | grep -v man"
# List big files in actual directory
alias bigfiles="du -x -h -a . 2> /dev/null | sort -r -h | head -30"
# Setup thefuck
eval $(thefuck --alias)
# Alias to fuck with auto validation
alias f="fuck --hard"
# Setup src to restart the shell
alias src="exec ${SHELL}"
# Alias to run the computer in KVM trough spice
alias kvmssd="sudo kvm /dev/nvme0n1 -m 15G -bios /usr/share/ovmf/OVMF.fd -spice port=5900,addr=127.0.0.1,disable-ticketing -vga qxl -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 -chardev spicevmc,id=spicechannel0,name=vdagent"
# Alias to change git origin
alias upsilon_upstream="git remote set-url origin https://github.com/UpsilonNumworks/Upsilon"
alias upsilon_yaya-cout="git remote set-url origin https://github.com/Yaya-Cout/Upsilon"
# Configure tldr with color theme
# alias tldr="tldr --theme base16"
# Alias pacman to yay
alias pacman="yay"
# Add pacman-autoremove command
alias pacman-autoremove="pacman -Qdtq | pacman -Rs -"
# Add pacman-bigpackages alias
alias "pacman-bigpackages"='expac -s "%-30n %m" | sort -rhk 2 | less'
# Add update-grub alias
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
# Add settings to rich
alias rich="rich --theme gruvbox-dark --hyperlinks --force-terminal"
# Add rule alias to rich --rule
alias rule="rich --rule"
# Add written data since boot alias
alias written-data="python3 -c 'print(int(open(\"/proc/diskstats\", \"r\").read().split(\"\n\")[0].strip().replace(\"  \", \"\").split(\" \")[9])*512/1000/1000/1000)'"
# Add read data since boot alias
alias read-data="python3 -c 'print(int(open(\"/proc/diskstats\", \"r\").read().split(\"\n\")[0].strip().replace(\"  \", \"\").split(\" \")[5])*512/1000/1000/1000)'"
# Get if gcp is in aliases, if yes, remove it
if alias | grep "gcp=" >/dev/null; then
  unalias gcp
fi

