{ config, pkgs, lib, ... }:

let
  # vosk isn't in nixpkgs either - pull the prebuilt manylinux wheel from PyPI
  # and patch its bundled libvosk.so for NixOS.
  vosk = pkgs.python3Packages.buildPythonPackage rec {
    pname = "vosk";
    version = "0.3.45";
    format = "wheel";

    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/py3/v/vosk/vosk-${version}-py3-none-manylinux_2_12_x86_64.manylinux2010_x86_64.whl";
      sha256 = "25e025093c4399d7278f543568ed8cc5460ac3a4bf48c23673ace1e25d26619f";
    };

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [ pkgs.stdenv.cc.cc.lib ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      cffi
      requests
      tqdm
      srt
      websockets
    ];

    doCheck = false;
    pythonImportsCheck = [ "vosk" ];
  };

  pythonEnv = pkgs.python3.withPackages (ps: [ vosk ]);

  nerd-dictation = pkgs.stdenv.mkDerivation {
    pname = "nerd-dictation";
    version = "unstable";

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/ideasman42/nerd-dictation/master/nerd-dictation";
      sha256 = "9e782539337affde7c858eaf6f9b173d429a86434b6392ed11ad862de294d10d";
    };

    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      mkdir -p $out/bin
      install -m755 $src $out/bin/nerd-dictation
      wrapProgram $out/bin/nerd-dictation \
        --prefix PATH : ${lib.makeBinPath [ pythonEnv pkgs.pulseaudio pkgs.ydotool ]}
    '';
  };
in
{
  environment.systemPackages = [
    nerd-dictation
    pkgs.ydotool
  ];

  systemd.user.services.ydotoold = {
    enable = true;
    description = "ydotool daemon";
    serviceConfig = {
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      Restart = "on-failure";
    };
    wantedBy = [ "graphical-session.target" ];
  };

  users.users.dan.extraGroups = [ "input" ];
}
