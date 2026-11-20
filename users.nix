# users.nix

{ ... }:
{
  ############################
  # User Accounts
  ############################
  users.users.dan = {
    isNormalUser = true;
    description  = "dan";

    # All group membership for dan lives here, not scattered across modules.
    extraGroups  = [
      "networkmanager"  # Network management
      "wheel"           # Sudo access
      "dialout"         # Serial devices (/dev/ttyUSB*, /dev/neato)
      "kvm"             # Android emulator / QEMU acceleration
      "libvirtd"        # virt-manager / libvirt
    ];
  };
}
