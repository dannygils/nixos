# packages.nix
{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
############################
# Overlays
############################
nixpkgs.overlays = [
    (final: prev: {
streamcontroller = prev.streamcontroller.overrideAttrs (old: {
postInstall = (old.postInstall or "") + ''
          substituteInPlace $out/usr/lib/streamcontroller/src/backend/Store/StoreBackend.py \
            --replace 'v = versions.get(gl.app_version, "main")' 'v = "main"'
        '';
      });
    })
  ];

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
cron
discord
dig
element-desktop
eza
fastfetch
ffmpeg
ffmpegthumbnailer
file
gamemode
gamescope
gdal
git
gnome-text-editor
graphicsmagick
kdePackages.gwenview
hyfetch
imagemagick
keepassxc
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
(python312.withPackages (ps: with ps; [
pip
pillow
pyserial
    ]))
pwvucontrol
python313
ripgrep
scanmem
scrcpy
    (unstable.signal-desktop.overrideAttrs (old: {
postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/signal-desktop \
          --add-flags "--password-store=gnome-libsecret"
      '';
    }))
socat
sqlcipher
sqlite
sshpass
streamcontroller
streamdeck-ui
tigervnc
typst
unrar
usbutils
uv
vim
vlc
vscode
warp-terminal
wayland
wget
wine
winetricks
xarchiver
xbindkeys
xdg-desktop-portal-gtk
zoxide
zoom-us
  ];
############################
# OBS Studio
############################
programs.obs-studio = {
enable = true;
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
obs-backgroundremoval
    ];
  };
boot.extraModulePackages = with config.boot.kernelPackages; [
v4l2loopback
  ];
boot.kernelModules = [ "v4l2loopback" ];
boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  '';
}