{ ... }:

{
  services.printing.enable = true;

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
