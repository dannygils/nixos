# virtualisation.nix: KVM/QEMU virtualization via libvirtd + virt-manager
{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  users.users.dan.extraGroups = [ "libvirtd" ];
}
