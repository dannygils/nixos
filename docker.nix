# docker.nix — Podman + NVIDIA container toolkit for GPU workloads

{ pkgs, ... }:
{
  ############################
  # Podman (Rootless Containers)
  ############################
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;          # alias `docker` -> `podman`
    defaultNetwork.settings.dns_enabled = true;
  };

  ############################
  # NVIDIA Container Toolkit
  ############################
  # Enables --device nvidia.com/gpu=all for Podman/Docker containers.
  # Requires the NVIDIA driver from nvidia.nix.
  hardware.nvidia-container-toolkit.enable = true;

  ############################
  # Container Packages
  ############################
  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
