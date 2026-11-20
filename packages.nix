# packages.nix
{ config, pkgs, ... }:

{

############################
# System Packages
############################
environment.systemPackages = with pkgs; [
adwaita-icon-theme
alacritty
android-tools
audacity
bat
bmon
bottles
btop
discord
dig
element-desktop
eza
f3d
fastfetch
ffmpeg
ffmpegthumbnailer
file
gdal
git
gnome-text-editor
graphicsmagick
kdePackages.gwenview
hyfetch
imagemagick
keepassxc
libreoffice
mpv
net-tools
nixd
nodejs_24
ntfs3g
obsidian
p7zip
pay-respects
pciutils
pdal
pinta
playerctl
plezy
protontricks
protonup-ng
# One python3 in the system path: a second (e.g. bare python313) collides on
# bin/python3 and one silently wins. Use `uv` for project-local envs.
(python313.withPackages (ps: with ps; [
  pip
  pillow
  pyserial
]))
pwvucontrol
ripgrep
scanmem
scrcpy
signal-desktop
socat
sqlcipher
sqlite
sshpass
tigervnc
typst
unrar
usbutils
uv
vim
vlc
vscode
warp-terminal
wget
wineWow64Packages.stable   # pkgs.wine is 32-bit only
winetricks
xarchiver
zoom-us
  ];
############################
# OBS Studio
############################
# No cudaSupport override: its only effect is autoAddDriverRunpath, which the
# obs-studio derivation already applies, and the override forces a local
# compile on every channel bump (including during the 04:00 auto-upgrade).
programs.obs-studio = {
  enable = true;
  enableVirtualCamera = true;   # sets up v4l2loopback; camera shows as "OBS Cam"
  plugins = with pkgs.obs-studio-plugins; [
    obs-pipewire-audio-capture
    obs-backgroundremoval
    wlrobs
  ];
};
}
