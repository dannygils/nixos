# fonts.nix

{ config, pkgs, ... }:
{
  ############################
  # Font Configuration
  ############################
  fonts.fontconfig.enable = true;

  ############################
  # Font Packages
  ############################
  fonts.packages = with pkgs; [
    # Terminal fonts
    nerd-fonts.meslo-lg           
    # nerd-fonts.jetbrains-mono

    # UI fonts
    source-sans-pro
    source-sans
    roboto
    font-awesome
  ];
}
