# streamdeck.nix
{ config, ... }:
{
  ############################
  # Stream Deck
  ############################
  # Installs streamdeck-ui and its packaged udev rules (same uaccess rule that
  # used to be hand-written here). autoStart = false because the user service
  # below owns startup -- the module's XDG autostart item would launch a second
  # copy (Hyprland does run XDG autostart via runXdgAutostartIfNone).
  programs.streamdeck-ui = {
    enable = true;
    autoStart = false;
  };

  systemd.user.services.streamdeck-ui = {
    description = "Stream Deck UI";
    wantedBy = [ "graphical-session.target" ];
    partOf   = [ "graphical-session.target" ];
    after    = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${config.programs.streamdeck-ui.package}/bin/streamdeck -n";
      Restart   = "on-failure";
    };
  };
}
