# configuration.nix: Top-level NixOS config wiring all modules together
{ ... }:

{
  ############################
  # Imports
  ############################
  imports = [
    ./audio.nix
    ./certs.nix
    ./controllers.nix
    ./cleanup.nix
    ./docker.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./hyprland.nix
    ./keyring.nix
    ./printing.nix
    ./nautilus.nix
    ./networking.nix
    ./nvidia.nix
    ./opensnitch.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./streamdeck.nix
    ./users.nix
    ./virtualisation.nix
    ./yubikey.nix
    ./zsh.nix
  ];

  ############################
  # Bootloader
  ############################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Cap boot entries so weekly auto-upgrades can't fill /boot
  boot.loader.systemd-boot.configurationLimit = 10;

  ############################
  # Time & Locale
  ############################
  time.timeZone = "America/New_York";

  ############################
  # Internationalization
  ############################
  i18n.defaultLocale = "en_US.UTF-8";

  # Input methods via ibus (per-user config done in GUI)
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  documentation.doc.enable = false;

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
  nixpkgs.config.nvidia.acceptLicense = true;

  ############################
  # System State Version
  ############################
  # Preserve data paths from your install version
  # WARNING: Do not change this value after initial installation
  system.stateVersion = "25.05";
}
