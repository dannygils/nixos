# configuration.nix: Top-level NixOS config wiring all modules together
{ config, pkgs, ... }:

{
  ############################
  # Imports
  ############################
  imports = [
    ./audio.nix
    ./certs.nix
    ./controllers.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./hyprland.nix
    ./keyring.nix
    ./nautilus.nix
    ./networking.nix
    ./nvidia.nix
    ./opensnitch.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./yubikey.nix
    ./zsh.nix
  ];

  ############################
  # Bootloader
  ############################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ############################
  # Time & Locale
  ############################
  time.timeZone = "America/New_York";

  ############################
  # Internationalization
  ############################
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  # Input methods via ibus (per-user config done in GUI)
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  ############################
  # AppImage Support
  ############################
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  ############################
  # Nixpkgs Configuration
  ############################
  nixpkgs.config.allowUnfree = true;

  ############################
  # System State Version
  ############################
  # Preserve data paths from your install version
  # WARNING: Do not change this value after initial installation
  system.stateVersion = "25.05";
}
