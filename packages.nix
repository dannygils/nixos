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
    dig

    # ---------- Development ----------
    git
    (python312.withPackages (ps: with ps; [
      pip
      pillow
    ]))
    vscode
    openvscode-server
    uv
    python313
    nodejs_24
    
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
    adwaita-icon-theme
    ffmpeg

    # ---------- GUI Applications - Productivity ----------
    gnome-text-editor
    keepassxc
    obsidian
    typst
    obs-studio

    # ---------- GUI Applications - Graphics ----------
    graphicsmagick
    pinta

    # ---------- GUI Applications - Media ----------
    mpv
    plex-desktop
    vlc

    # ---------- GUI Applications - Communication ----------
    signal-desktop

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
