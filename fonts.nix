# fonts.nix

{ pkgs, ... }:
{
  ############################
  # Font Packages
  ############################
  # fonts.fontconfig.enable is already the default
  fonts.packages = with pkgs; [
    # Terminal fonts
    nerd-fonts.meslo-lg
    # nerd-fonts.jetbrains-mono

    # UI fonts
    source-sans        # supersedes source-sans-pro (same family, new name)
    roboto
    font-awesome
  ];
}
