# networking.nix: Hostname, NetworkManager, DNS, and extra /etc/hosts entries
{ config, pkgs, lib, ... }:
{
  ############################
  # Hostname
  ############################
  networking.hostName = "nixos";

  ############################
  # NetworkManager
  ############################
  networking.networkmanager.enable = true;

  ############################
  # DNS Configuration
  ############################
  # Disable NM's dnsmasq handling; use custom DNS
  networking.networkmanager.dns = "none";
  networking.networkmanager.insertNameservers = [ "192.168.1.2" ];
  networking.nameservers = [ "192.168.1.2" ];

  ############################
  # Static Host Entries
  ############################
  networking.extraHosts = ''
    127.0.0.1 nixos.local nixos localhost
    ::1       nixos.local nixos localhost
    192.168.1.69 tower.local
  '';

}
