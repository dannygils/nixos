# hyprland.nix

{ config, lib, pkgs, ... }:
{
  ############################
  # Display server & login
  ############################
  # services.xserver.enable is here only so SDDM runs on X11, which is still
  # the most reliable way to drive it. SDDM itself launches the Wayland session.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # Hide the uwsm-managed session from the login screen
  services.displayManager.sessionPackages = lib.mkForce [
    (pkgs.symlinkJoin {
      name = "hyprland-session-no-uwsm";
      paths = [ config.programs.hyprland.package ];
      postBuild = ''
        rm -f $out/share/wayland-sessions/hyprland-uwsm.desktop
      '';
      passthru.providedSessions = [ "hyprland" ];
    })
  ];

  ############################
  # Hyprland Wayland compositor
  ############################
  # This module also enables: xdg.portal + xdg-desktop-portal-hyprland and -gtk,
  # programs.xwayland, programs.dconf and security.polkit. Don't repeat them.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  ############################
  # Session target
  ############################
  # Without uwsm nothing activates graphical-session.target, so user services
  # that are `wantedBy` it never start. Starting hyprland-session.target from
  # hyprland.conf pulls graphical-session.target up with it.
  # Requires in ~/.config/hypr/hyprland.conf:
  #   exec-once = systemctl --user start hyprland-session.target
  systemd.user.targets.hyprland-session = {
    description = "Hyprland compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants   = [ "graphical-session-pre.target" ];
    after   = [ "graphical-session-pre.target" ];
  };

  ############################
  # Lock screen & idle daemon
  ############################
  # Installs hyprlock, creates its PAM service (so the YubiKey/password prompt
  # works instead of falling back to su), and enables the hypridle user service.
  programs.hyprlock.enable = true;

  ############################
  # Keyboard layout (XKB)
  ############################
  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };

  ############################
  # Hyprland-specific packages
  ############################
  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprshot
    wofi
    mako
    waybar
    glib            # gsettings CLI
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
