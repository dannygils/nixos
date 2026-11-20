{ ... }:

{
  services.printing.enable = true;

  # Defaults to on whenever Avahi is enabled. The printer below is declared
  # explicitly, so the discovery daemon has nothing to do.
  services.printing.browsed.enable = false;

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother";
        description = "Brother HL-L2340DW (Tower)";
        deviceUri = "ipp://192.168.1.69:631/printers/Brother";
        model = "everywhere";
      }
    ];
    ensureDefaultPrinter = "Brother";
  };
}
