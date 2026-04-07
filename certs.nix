# certs.nix

{ config, pkgs, ... }:

{
  ############################
  # Custom Certificates
  ############################
  security.pki.certificateFiles = [
    /home/dan/local-ca/certs/ca.crt  #home.lan
  ];
}
