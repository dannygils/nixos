# packages.nix
{ config, pkgs, ... }:
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
    plex-desktop
    protontricks
    protonup-ng
    (python312.withPackages (ps: with ps; [
      pip
      pillow
    ]))
    pwvucontrol
    python313
    ripgrep
    scanmem
    scrcpy
    signal-desktop
    socat
    sqlcipher
    sqlite
    sshpass
    streamcontroller
    streamdeck-ui
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