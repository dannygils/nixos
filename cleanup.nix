# cleanup.nix: Nix GC/optimise, auto-upgrade, disk health, temperature logging
{ config, lib, pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # Nix store garbage collection & optimisation
  # ---------------------------------------------------------------------------
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # ---------------------------------------------------------------------------
  # NixOS auto-upgrade (runs at 04:00 with a random delay)
  #
  # Builds /etc/nixos/configuration.nix, which is a symlink to
  # /home/dan/.config/nixos/configuration.nix -- no extra flags needed.
  # `--upgrade` bumps the channel set with `nix-channel`; it never moves you
  # to a new NixOS release. Do that by hand with `nix-channel --add`.
  # ---------------------------------------------------------------------------
  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    randomizedDelaySec = "45min";
  };

  # ---------------------------------------------------------------------------
  # SSD trim (weekly)
  # ---------------------------------------------------------------------------
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # ---------------------------------------------------------------------------
  # Systemd journal size cap
  # ---------------------------------------------------------------------------
  services.journald.extraConfig = ''
    SystemMaxUse=1G
    MaxRetentionSec=1month
  '';

  # ---------------------------------------------------------------------------
  # SMART disk health monitoring
  # ---------------------------------------------------------------------------
  services.smartd = {
    enable = true;
    autodetect = true;
  };

  # ---------------------------------------------------------------------------
  # Firmware updates (fwupd)
  # ---------------------------------------------------------------------------
  services.fwupd.enable = true;

  # ---------------------------------------------------------------------------
  # Periodic CPU / GPU temperature logger
  # Output goes to the journal (size-capped above):
  #   journalctl -u temp-log --since today
  # ---------------------------------------------------------------------------
  systemd.services.temp-log = {
    description = "CPU and GPU temperature snapshot";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "temp-log" ''
        ${pkgs.lm_sensors}/bin/sensors
        ${lib.getBin config.hardware.nvidia.package}/bin/nvidia-smi \
          --query-gpu=temperature.gpu,power.draw,clocks.current.graphics \
          --format=csv,noheader
      '';
    };
  };

  systemd.timers.temp-log = {
    description = "Run temp-log every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "5min";
      Unit = "temp-log.service";
    };
  };
}
