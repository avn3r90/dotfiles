{ config, pkgs, ... }:

{
 programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      #  { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "tjkirch";
    };
  
    shellAliases = {
      catt = "bat";
      update = "sudo nixos-rebuild switch --flake ~/nix/#toster";
      lss = "eza --icons";
      mvv = "mv -v";
      cpr = "rsync -ah --progress";
      
    };
    history.size = 10000;
  };
}
