# packages.nix: Global environment.systemPackages
{ config, pkgs, lib, ... }:

{
  ############################
  # System Packages
  ############################
  environment.systemPackages = with pkgs; [
    
    # ---------- CLI Tools - Core ----------
    bat
    eza
    fastfetch
    file
    hyfetch
    net-tools
    pciutils
    ripgrep
    socat
    usbutils
    vim
    wget
    zoxide

    # ---------- CLI Tools - System ----------
    cron
    ntfs3g
    pay-respects
    sshpass
    xbindkeys
    bmon
    btop

    # ---------- Development ----------
    git
    go
    python312
    python312Packages.pip
    python312Packages.pillow
    vscode
    openvscode-server

    # ---------- Database ----------
    sqlcipher
    sqlite

    # ---------- Terminals ----------
    alacritty
    warp-terminal

    # ---------- Wayland/Desktop Environment ----------
    wayland
    xdg-desktop-portal-gtk
    ffmpegthumbnailer
    imagemagick
    playerctl

    # ---------- GUI Applications - Productivity ----------
    gnome-text-editor
    keepassxc
    obsidian
    typst

    # ---------- GUI Applications - Graphics ----------
    graphicsmagick
    pinta

    # ---------- GUI Applications - Media ----------
    mpv
    plex-desktop
    vlc

    # ---------- GUI Applications - Communication ----------
    signal-desktop
    zoom-us

    # ---------- GUI Applications - Utilities ----------
    p7zip
    xarchiver

    # ---------- Gaming - Emulation/Tools ----------
    bottles
    gamemode
    protontricks
    protonup-ng  # Swapped out protonup-qt (insecure as of 2025-12-25 / 25.11)
    scanmem
    wine
    winetricks

    # ---------- Android ----------
    android-tools
    scrcpy
  ];
}
