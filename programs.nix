# programs.nix

{ ... }:
{
############################
# Desktop Applications
############################
programs.firefox.enable = true;
programs.dconf.enable   = true;

############################
# Shell Utilities
############################
programs.zoxide.enable  = true;

############################
# Gaming - Steam
############################
programs.steam = {
enable = true;
remotePlay.openFirewall                = true;
localNetworkGameTransfers.openFirewall = true;
  };

programs.gamemode.enable  = true;
programs.gamescope.enable = true;

############################
# udev rules
############################
services.udev.extraRules = ''
    # uinput: lets streamdeck-ui and ydotool synthesise input events.
    # TAG+="uaccess" ACLs the node to the logged-in user, so membership in the
    # `input` group (which would expose every keyboard) is not needed.
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess", GROUP="input", MODE="0660"
    # Neato XV-21 -> /dev/neato
    SUBSYSTEM=="tty", ATTRS{idVendor}=="2108", ATTRS{idProduct}=="780b", SYMLINK+="neato", MODE="0660", GROUP="dialout"
  '';

############################
# Notes
############################
# To load Chromium once with flakes - This is for when I need to use web-based phone flashing:
# nix run "nixpkgs#chromium" --extra-experimental-features nix-command --extra-experimental-features flakes -- https://grapheneos.org/install/web
}
