# virtualisation.nix: KVM/QEMU virtualization via libvirtd + virt-manager
{ ... }:

{
  virtualisation.libvirtd.enable = true;

  # Installs virt-manager and enables the dconf support it needs
  programs.virt-manager.enable = true;

  # The `libvirtd` group for dan is declared in users.nix
}
