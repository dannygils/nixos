# desktop.nix: Hyprland-based Wayland desktop (WM, DM, portals, helpers)
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
    # --- Hyprland core utilities ---
    hyprlock
    hypridle
    # hyprlauncher - undercooked right now
    hyprpaper
    hyprshot

    # --- Wayland/XWayland helpers ---
    xwayland-satellite

    # --- Launchers ---
    fuzzel
    wofi

    # --- Notifications ---
    mako

    # --- Status bar ---
    waybar

    # --- File manager ---
    nautilus                      
    nautilus-open-any-terminal

    # --- System/utilities ---
    glib
    image-roll
    lxqt.lxqt-policykit
  ];
}
