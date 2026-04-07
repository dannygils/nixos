# nautilus.nix

{ config, pkgs, ... }:

{
  ############################
  # Nautilus Extensions
  ############################
  # NOTE: nautilus-open-any-terminal also in hyprland.nix
  environment.systemPackages = with pkgs; [
    nautilus-python
  ];

  ############################
  # Extension Discovery
  ############################
  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];

  ############################
  # GSettings Schema
  ############################
  # Expose the nautilus-open-any-terminal GSettings schema system-wide so that
  # both Nautilus and the `gsettings` CLI can see
  # `com.github.stunkymonkey.nautilus-open-any-terminal`.
  environment.sessionVariables.GSETTINGS_SCHEMA_DIR =
    "${pkgs.nautilus-open-any-terminal}/share/gsettings-schemas/${pkgs.nautilus-open-any-terminal.name}/glib-2.0/schemas";

  ############################
  # Configuration Notes
  ############################
  # To set the terminal used by the extension, run:
  # gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal 'alacritty'
}
