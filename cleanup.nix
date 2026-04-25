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
  # NixOS / flake auto-upgrade (runs at 04:00 with a random delay)
  # ---------------------------------------------------------------------------
  system.autoUpgrade = {
    enable = true;
    flake = "/home/dan/.config/nixos";
    flags = [ "--update-input" "nixpkgs" "-L" ];
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
  # NVIDIA persistence daemon (reduces GPU init latency)
  # ---------------------------------------------------------------------------
  hardware.nvidia.nvidiaPersistenced = true;

  # ---------------------------------------------------------------------------
  # Periodic CPU / GPU temperature logger
  # Logs to /var/log/temps.log every 5 minutes
  # ---------------------------------------------------------------------------
  systemd.services.temp-log = {
    description = "CPU and GPU temperature snapshot";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "temp-log" ''
        echo "--- $(date --iso-8601=seconds) ---" >> /var/log/temps.log
        ${pkgs.lm_sensors}/bin/sensors >> /var/log/temps.log
        ${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi \
          --query-gpu=temperature.gpu,power.draw,clocks.current.graphics \
          --format=csv,noheader >> /var/log/temps.log
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
      Persistent = true;
    };
  };

  # ---------------------------------------------------------------------------
  # Make NixOS-managed timers persistent so missed runs catch up on next boot
  # ---------------------------------------------------------------------------
  systemd.timers.nix-gc.timerConfig.Persistent = true;
  systemd.timers.nix-optimise.timerConfig.Persistent = true;
  systemd.timers.nixos-upgrade.timerConfig.Persistent = true;
}
