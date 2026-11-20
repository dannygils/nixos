# nautilus.nix

{ pkgs, ... }:

{
  ############################
  # File Manager
  ############################
  environment.systemPackages = with pkgs; [
    nautilus
  ];

  ############################
  # Nautilus Extensions
  ############################
  # Installs nautilus-python + the extension, links the extension dir, and sets
  # the terminal through dconf -- replaces the old manual pathsToLink /
  # GSETTINGS_SCHEMA_DIR / `gsettings set` dance.
  programs.nautilus-open-any-terminal = {
    enable   = true;
    terminal = "alacritty";
  };
}
