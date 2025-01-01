{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true; # Włączenie bash-completion

    # Dodatkowe ustawienia dla Bash
    shellAliases = {
      ll = "ls -la";
      grep = "grep --color=auto";
    };

    initExtra = ''
      # Niestandardowe ustawienia bash
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      shopt -s histappend
      shopt -s checkwinsize
    '';
  };
}
