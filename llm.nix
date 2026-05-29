# llm.nix — Local LLM inference (Ollama + Open WebUI)

{ config, pkgs, lib, ... }:
{
  ############################
  # Ollama (LLM Backend)
  ############################
  services.ollama = {
    enable       = true;
    acceleration = "cuda";
    host         = "0.0.0.0";
    port         = 11434;
    openFirewall = true;
    loadModels   = [ "phi3" ];
    environmentVariables = {
      OLLAMA_NO_CLOUD       = "1";
      OLLAMA_ORIGINS        = "*";
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_CONTEXT_LENGTH  = "4096";
    };
  };

  ############################
  # Open WebUI (Chat Frontend)
  ############################
  services.open-webui = {
    enable = true;
    port   = 3000;

    environment = {
      OLLAMA_API_BASE_URL  = "http://127.0.0.1:11434";
      WEBUI_AUTH           = "False";
      WEBUI_SECRET_KEY     = "";
      RAG_EMBEDDING_ENGINE = "ollama";
      RAG_EMBEDDING_MODEL  = "mxbai-embed-large:latest";
      OAUTH_SESSION_TOKEN_ENCRYPTION_KEY = "local-only-no-auth";
      # Allow Open WebUI tools to pip install dependencies.
      # PYTHONPATH must include pip+setuptools site-packages so that
      # sys.executable (the raw Nix Python) can find them via -m pip.
      PIP_TARGET  = "/var/lib/open-webui/pip-packages";
      PYTHONPATH  = "${pkgs.python3Packages.pip}/${pkgs.python3.sitePackages}:${pkgs.python3Packages.setuptools}/${pkgs.python3.sitePackages}:/var/lib/open-webui/pip-packages";
      HOME        = "/var/lib/open-webui";
      #OLLAMA_NUM_CTX = "4096";  # down from 32768, saves ~3 GiB VRAM
    };
  };

  ############################
  # Manual Start Only
  ############################
  # Don't start on boot — use:
  #   sudo systemctl start ollama open-webui
  systemd.services.ollama.wantedBy   = lib.mkForce [];
  systemd.services.open-webui.wantedBy = lib.mkForce [];

  # Ensure the pip target directory exists before open-webui starts
  systemd.services.open-webui.preStart = lib.mkAfter ''
    mkdir -p /var/lib/open-webui/pip-packages
  '';

  ############################
  # Network Isolation
  ############################
  # Restrict both services to localhost only — no internet access
#  systemd.services.ollama.serviceConfig = {
#    IPAddressDeny            = "any";
#    IPAddressAllow           = [ "localhost" "127.0.0.0/8" "192.168.1.69" ];
#    MemoryDenyWriteExecute   = lib.mkForce false;  # CUDA JIT requires W+X memory
#  };

#  systemd.services.open-webui.serviceConfig = {
#    IPAddressDeny  = "any";
#    IPAddressAllow = [ "localhost" "127.0.0.0/8" "192.168.1.69" ];
#  };
}
