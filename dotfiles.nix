# dotfiles.nix: System-wide app configs in /etc/xdg (kitty, mako, waybar)
{ config, pkgs, lib, ... }:
{
  ############################
  # System-wide XDG Configs
  ############################
  # Put app configs in the system XDG directory (/etc/xdg)
  # so they apply without touching $HOME
  environment.etc = {

    ############################
    # Mako Notifications
    ############################
    "xdg/mako/config" = {
      source = ./mako_config;
    };
  };
}
