#!/bin/bash

set -e

echo -e "
░█▀█░█▀▀░█░█░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░
░█░█░█▀▀░█▄█░░░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░
░▀░▀░▀▀▀░▀░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀
"

echo -e "\nInstall utils ...?\n"

xorg_windomanager="
i3-gaps
lightdm
lightdm-gtk-greeter
lightdm-webkit-theme-litarvan
mesa
xorg-server
xorg-apps
xorg-xinit
xorg-xrandr
"
read -p "Install i3-wm and xorg? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $xorg_windomanager
fi

amd_cpu_gpu_specific="
amd-ucode
xf86-video-amdgpu
mesa
vulkan-radeon
libva-mesa-driver
"
read -p "Install packages for AMD CPU + GPU ? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $amd_cpu_gpu_specific
fi

intel_cpu_gpu_specific="
intel-ucode
"
read -p "Install packages for Intel CPU + GPU ? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $intel_cpu_gpu_specific
fi

audio="
alsa-utils
alsa-plugins
alsa-lib
pipewire
pipewire-alsa
pipewire-pulse
pipewire-jack
wireplumber
pamixer
"
read -p "Install alsa and pulseaudio packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $audio
fi

bluetooth="
bluez
bluez-utils
blueman
pulseaudio-bluetooth
libldac
"
read -p "Install bluetooth packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $bluetooth
fi

bspwn="
bspwm
sxhkd
"
read -p "Install bspwm packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $bspwn
fi

awesome="
awesome
luarocks
vicious
lua-lgi
"
read -p "Install awesomewm packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $awesome
fi

qtile="
qtile
python-iwlib
"
read -p "Install qtile packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $qtile
fi

xfce="
xfce4
"
read -p "Install xfce packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $xfce
fi

gnome_shell="
gnome-shell
gnome-tweaks
gnome-control-center
gdm
"
read -p "Install gnome shell packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $gnome_shell
fi

system_libs_utils_misc="
volumeicon
network-manager-applet
openvpn
networkmanager-openvpn
xwallpaper
inetutils
lvm2
openssh
ntp
pandoc
ufw
w3m
xautolock
playerctl
usbutils
pavucontrol
flameshot
dunst
cronie
qt5ct
gtk-engine-murrine
gtk-engines
net-tools
lxappearance
arandr
wmctrl
wireguard-tools
trayer
nextcloud-client
libsecret
gnome-keyring
reflector
devtools
pacman-contrib
pacman-mirrorlist
fwupd
bolt
brightnessctl
handlr-regex
cosign
"
read -p "Install misc system libs/utils/backends? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $system_libs_utils_misc
fi

read -p "Setup defaults for UFW? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # setup ufw
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw enable
  sudo systemctl enable ufw
fi

virtualization="
qemu
virt-manager
virt-viewer
dnsmasq
vde2
bridge-utils
openbsd-netcat
ebtables
iptables
dmidecode
"
read -p "Install virtualization packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $virtualization
  sudo usermod -aG libvirt $USER
  sudo systemctl enable libvirtd
fi

cli_tools="
wget
diff-so-fancy
eza
bat
prettyping
fzf
fd
ncdu
tealdeer
the_silver_searcher
ripgrep
ranger
xplr
ueberzug
tmux
jq
nmap
arp-scan
figlet
htop
fastfetch
onefetch
nload
zip
unzip
speedtest-cli
lolcat
cowsay
fortune-mod
xclip
bashtop
hub
github-cli
calcurse
bind
moreutils
nnn
skim
glances
picocom
sysstat
bpytop
tree
tokei
pwgen
duf
zoxide
bottom
difftastic
k9s
duf
dust
procs
argocd
sad
starship
gum
dog
zellij
visidata
dagger
btop
yazi
ffmpegthumbnailer
unarchiver
poppler
"
read -p "Install cli_tools? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $cli_tools
fi

emacs_packages="
emacs-nativecomp
"

read -p "Install emacs packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $emacs_packages
fi

vim_related="
neovim
neovim-qt
vim
ctags
xsel
stylua
python-pynvim
python-msgpack
"
read -p "Install vim packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $vim_related
fi

applications="
zsh
git
alacritty
wezterm
firefox
chromium
qutebrowser
vimb
thunderbird
docker
docker-compose
docker-buildx
python-pywal
discord
rofi
dmenu
fuzzel
feh
picom
thunar
tumbler
zathura
zathura-pdf-poppler
mpv
yt-dlp
graphicsmagick
imagemagick
flameshot
sxiv
gnome-disk-utility
signal-desktop
falkon
guvcview
bitwarden
"
read -p "Install assorted applications, eg. browser/terminal/email? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $applications
  sudo usermod -aG docker $USER
  sudo systemctl enable docker
fi

development="
base-devel
python
python-pip
pyenv
poetry
python-pipenv
clang
kubectl
kubectx
kustomize
helm
kubeseal
minikube
nodejs
npm
shellcheck
yamllint
python-cookiecutter
ansible
ansible-lint
shfmt
prettier
deno
python-pylint
flake8
autopep8
python-black
python-jedi
eksctl
gitui
lazygit
cilium-cli
postgresql-libs
"
read -p "Install development packags? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $development
fi

fonts="
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-extra
gnu-free-fonts
ttf-bitstream-vera
ttf-droid
ttf-liberation
ttf-dejavu
ttf-caladea 
ttf-carlito 
ttf-liberation
ttf-opensans
ttf-ubuntu-font-family
nerd-fonts
"
read -p "Install fonts? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $fonts
fi

themes="
arc-gtk-theme
arc-icon-theme
capitaine-cursors
materia-gtk-theme
papirus-icon-theme
"
read -p "Install themes? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $themes
fi

read -p "Install paru AUR-helper? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  mkdir -p ~/Applications
  git clone https://aur.archlinux.org/paru.git ~/Applications/paru
  cd ~/Applications/paru
  makepkg -si
  cd
fi

aur_bluetooth="
pulseaudio-modules-bt
"
read -p "Install bluetooth-specific AUR packages using paru? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru -S $aur_bluetooth
fi

aur="
zplug
cli-visualizer
figlet-fonts
magic-wormhole
pfetch-rs
polybar
slack-desktop
spotify
tty-clock-git
git-delta
glow
duf
lain-git
awesome-freedesktop-git
kind
hadolint
luacheck
dive
jo
lazydocker
catppuccin-gtk-theme-frappe 
neovim-remote
slides
go-task
go-yq
drawio-desktop
tenv
tflint
pspg
"
read -p "Install AUR packages using paru? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $aur
fi

read -p "Create directories for Applications/python venvs? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # create dir for virtualenvs
  mkdir ~/.virtualenvs

  # Create Applications dir and clone some usefull stuff
  mkdir ~/Applications
fi

hyprland="
hyprland
waybar
qt5-wayland
qt6-wayland
wofi
"
read -p "Install hyprland AUR packages using paru? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $hyprland
fi

riverwm="
river
waybar
foot
qt5-wayland
qt6-wayland
wlr-randr
wofi
mako
swaybg
swaylock
swayidle
xdg-desktop-portal
xdg-desktop-portal-wlr
riverwm-utils
python-pywayland
grim
slurp
xdg-desktop-portal-gtk
wl-clipboard
wayshot
lswt
wideriver
"
read -p "Install riverwm and other wayland packages using paru? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $riverwm
fi
