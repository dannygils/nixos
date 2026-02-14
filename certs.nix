# certs.nix: Custom SSL/TLS certificate configuration
{ config, pkgs, ... }:

{
  ############################
  # Custom Certificates
  ############################
  security.pki.certificateFiles = [
    /home/dan/local-ca/certs/ca.crt  #home.lan
  ];
}
