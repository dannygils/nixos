# zsh.nix

{ config, pkgs, lib, ... }:
{
  ############################
  # Shell Configuration
  ############################
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  ############################
  # Zsh Program Settings
  ############################
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zsh-autoenv.enable = false;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = "";

    ############################
    # Oh My Zsh
    ############################
    ohMyZsh = {
      enable = true;
      theme = "";  # Leave empty to avoid theme-path issues
      plugins = [ "git" "z" ];
    };

    ############################
    # Interactive Shell Init
    ############################
    interactiveShellInit = ''
      ############################
      # History settings
      ############################
      HISTFILESIZE=10000
      HISTSIZE=500
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_SPACE
      setopt SHARE_HISTORY

      ############################
      # Aliases - File operations
      ############################
      alias ls='eza --icons --group-directories-first'
      alias ll='eza --icons --group-directories-first --all -l'
      alias bat='bat --theme=base16'
      alias cls='clear'
      alias home='cd ~/'
      chpwd() { ll }

      ############################
      # Aliases - System management
      ############################
      alias rebuild='sudo nixos-rebuild switch'
      alias update='sudo nixos-rebuild switch --upgrade'
      alias garbage='sudo nix-collect-garbage -d'
      alias generations='nix-env --list-generations'

      ############################
      # Aliases - Wayland/Hyprland
      ############################
      alias waybarr='pkill waybar 2>/dev/null || true; nohup waybar >/tmp/waybar.log 2>&1 &'
      alias waye='nano /home/dan/.config/waybar/config.jsonc'
      alias hype='nano /home/dan/.config/hypr/hyprland.conf'
      alias hyprr='hyprctl reload'

      ############################
      # Prompt configuration
      ############################
      # Make sure no old Bash-style PS1 bleeds through
      # unset PS1 PROMPT RPROMPT

      # Powerlevel10k (source directly from the Nix store)
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };
}
