# streamdeck.nix
{ pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", TAG+="uaccess"
  '';

  systemd.user.services.streamdeck-ui = {
    description = "Stream Deck UI";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.streamdeck-ui}/bin/streamdeck -n";
      Restart = "on-failure";
    };
  };
}
