# opensnitch.nix: OpenSnitch firewall service and UI package
{ config, pkgs, ... }:

{
  ############################
  # OpenSnitch Service
  ############################
  services.opensnitch = {
    enable = true;
    settings = {
      DefaultAction = "allow";
      LogLevel = 1;
      Firewall = "iptables";
      ProcMonitorMethod = "ebpf";
    };
  };

  ############################
  # OpenSnitch GUI
  ############################
  environment.systemPackages = with pkgs; [
    opensnitch-ui
  ];
}
