#!/bin/bash

set -e

cat <<'EOF'
 ___           _        _ _   ____            _                         
|_ _|_ __  ___| |_ __ _| | | |  _ \ __ _  ___| | ____ _  __ _  ___  ___ 
 | || '_ \/ __| __/ _` | | | | |_) / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
 | || | | \__ \ || (_| | | | |  __/ (_| | (__|   < (_| | (_| |  __/\__ \
|___|_| |_|___/\__\__,_|_|_| |_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
                                                        |___/           
EOF

amd_cpu_gpu_specific="
amd-ucode
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
mesa
vulkan-intel
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
read -p "Install audio packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $audio
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

# see: https://wiki.archlinux.org/title/TLP
tlp="
tlp
tlp-rdw
ethtool
smartmontools
"
read -p "Install and enable tlp to manage battery? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $tlp
  sudo systemctl enable tlp.service
  sudo systemctl enable NetworkManager-dispatcher.service
  sudo systemctl mask systemd-rfkill.service
  sudo systemctl mask systemd-rfkill.socket
fi

system_libs_utils_misc="
network-manager-applet
openvpn
networkmanager-openvpn
inetutils
lvm2
openssh
openssl
ntp
pandoc
ufw
playerctl
usbutils
qt5ct
qt6ct
kvantum
kvantum-qt5
gtk-engine-murrine
gtk-engines
net-tools
lxappearance
wireguard-tools
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
kanshi
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
lynx
w3m
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
jq
nmap
arp-scan
figlet
htop
fastfetch
nload
zip
unzip
lolcat
cowsay
fortune-mod
hub
github-cli
bind
moreutils
picocom
sysstat
tree
tokei
pwgen
duf
zoxide
k9s
procs
sad
gum
dog
dagger
btop
yazi
ffmpegthumbnailer
unarchiver
grc
direnv
magic-wormhole
git-delta
glow
go-task
just
go-yq
7zip
"
read -p "Install cli_tools? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $cli_tools
fi

emacs_packages="
emacs
"

read -p "Install emacs packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $emacs_packages
fi

vim_related="
neovim
vim
ctags
stylua
python-pynvim
python-msgpack
lua51
luarocks
tree-sitter-cli
tree-sitter-grammars
"
read -p "Install vim packages? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $vim_related
fi

applications="
git
bash
bash-completion
zsh
zsh-completions
starship
fish
fisher
zellij
alacritty
kitty
wezterm
firefox
chromium
qutebrowser
thunderbird
filezilla
discord
fuzzel
thunar
mpv
vlc
yt-dlp
imagemagick
flameshot
gnome-disk-utility
signal-desktop
guvcview
bitwarden
drawio-desktop
imv
zed
element-desktop
"
# you might need to run element-desktop from cli with this argument to get it
# to play nice with gnome-keyring, should only need to do it once.
# 'element-desktop --password-store=gnome-libsecret'
read -p "Install assorted applications, eg. browser/terminal/email? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $applications
  sudo usermod -aG docker $USER
  sudo systemctl enable docker
fi

development="
docker
docker-compose
docker-buildx
base-devel
python
python-pip
pyenv
poetry
uv
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
ansible
ansible-lint
shfmt
prettier
deno
python-pylint
flake8
autopep8
python-black
lazygit
postgresql-libs
rust
rust-analyzer
markdownlint-cli2
sqlfluff
luacheck
tflint
pyright
eslint
talosctl
cilium-cli
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

aur="
ast-grep
nodejs-markdown-toc
luajit-tiktoken-bin
zplug
cli-visualizer
pfetch-rs
slack-desktop
tty-clock-git
kind
hadolint-bin
lazydocker
neovim-remote
slides
tenv
pspg
pwvucontrol
arc-gtk-theme 
kvantum-theme-arc
sioyek
tesseract-data-eng
nvimpager
fooyin
wdisplays
"
# TODO: use arc-gtk-theme-git ?

read -p "Install AUR packages using paru? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $aur
fi

hyprland="
hyprland
waybar
qt5-wayland
qt6-wayland
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
wl-clipboard
wayshot
lswt
wideriver
swww
"
read -p "Install riverwm and other wayland packages using paru? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $riverwm
fi

flatpak="
flatpak
xdg-desktop-portal-gtk
"
read -p "Setup flatpak and bottles? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $flatpak
  flatpak install com.usebottles.bottles
fi

japanese_input="
fcitx5-im
fcitx5-mozc
"
read -p "Setup Japanese Input? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S $japanese_input
  echo "Enabling Japanese locale ..."
  sudo sed '/#ja_JP.UTF-8/s/^#//g' -i /etc/locale.gen
  echo "Generating locales ..."
  sudo locale-gen
fi

read -p "Setup nix? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman --needed -S nix
  sudo systemctl enable nix-daemon.service
  sudo groupadd nix-users
  sudo usermod -aG nix-users zander
fi

# See: https://aur.archlinux.org/packages/makemkv?O=0
# https://cable.ayra.ch/makemkv/
# https://forum.makemkv.com/forum/viewtopic.php?t=39368
optical="
lsscsi
flac
whipper
cdparanoia
libdvdcss
dvd+rw-tools
handbrake
vlc
vlc-plugins-all
kodi
jre8-openjdk
libbluray
libdvdnav
aribb24
makemkv
makemkv-libaacs
"
read -p "Install tools for optical drives and ripping using paru? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  paru --needed -S $optical
fi
