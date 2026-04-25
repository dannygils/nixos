# hyprland.nix

{ config, pkgs, lib, ... }:
{
  ############################
  # Display server & login
  ############################
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  ############################
  # Hyprland Wayland compositor
  ############################
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  ############################
  # Keyboard layout (XKB)
  ############################
  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };

  ############################
  # Wayland plumbing & portals
  ############################
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  programs.xwayland.enable = true;

  ############################
  # Hyprland-specific packages
  ############################
  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    hyprshot
    xwayland-satellite
    fuzzel
    wofi
    mako
    waybar
    nautilus                      
    nautilus-open-any-terminal
    glib
    image-roll
    lxqt.lxqt-policykit
  ];

############################
# Hyprshot default directory
############################
environment.sessionVariables = {
  HYPRSHOT_DIR = "/home/dan/Pictures/hyprshot";
};

}
