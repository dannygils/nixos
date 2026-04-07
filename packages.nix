# packages.nix

{ config, pkgs, lib, ... }:

{
  ############################
  # System Packages
  ############################
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    alacritty
    android-tools
    bat
    bmon
    bottles
    btop
    cron
    dig
    eza
    fastfetch
    ffmpeg
    ffmpegthumbnailer
    file
    gamemode
    git
    gnome-text-editor
    graphicsmagick
    hyfetch
    imagemagick
    keepassxc
    mpv
    net-tools
    nodejs_24
    ntfs3g
    obs-studio
    obsidian
    openvscode-server
    p7zip
    pay-respects
    pciutils
    pinta
    playerctl
    plex-desktop
    protontricks
    protonup-ng
    (python312.withPackages (ps: with ps; [
      pip
      pillow
    ]))
    python313
    ripgrep
    scanmem
    scrcpy
    signal-desktop
    socat
    sqlcipher
    sqlite
    sshpass
    typst
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
  ];
}
