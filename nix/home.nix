{ config, pkgs, ... }:

{
  home.username = "fi9o";
  home.homeDirectory = "/home/fi9o";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
    # DWM i graty
    pkgs.dwm
    pkgs.st
    pkgs.dmenu
    pkgs.sxhkd
  
    # konsola
    pkgs.asciinema
    pkgs.bat
    pkgs.eza
    pkgs.fzf
    pkgs.btop
    pkgs.micro
    pkgs.yazi
    pkgs.gh
    pkgs.git
    pkgs.fastfetch
    #pkgs.grim
    #pkgs.patool
    pkgs.ncdu
    pkgs.nh
    #pkgs.nix-search
    #pkgs.nvd
    pkgs.nix-tree
    pkgs.thefuck
    pkgs.tldr
    pkgs.yadm

    # xfce
    pkgs.xfce.xfce4-battery-plugin
    pkgs.xfce.xfce4-whiskermenu-plugin
    pkgs.qogir-icon-theme
    pkgs.qogir-theme

    # inne
    #pkgs.ghostty
    pkgs.kitty
    pkgs.blueman
    pkgs.signal-desktop
    pkgs.thunderbird
    pkgs.kodi
    #pkgs.qbittorrent
    #pkgs.stremio
    #pkgs.vlc
  ];

  imports = [
  	./modules/zsh.nix
  	./modules/firefox.nix
  ];



  programs.git = {
    enable = true;
    userName = "avn3r90";
    userEmail = "fi9o@outlook.com";  
  };
  
  home.shellAliases = {
  l = "eza -l --icons";
 	lss = "eza --icons";
 	ll = "eza -la --icons";
 	ld = "eza -lD --icons";
 	cp = "cp -i";
 	mv = "mv -i";
 	mkdir = "mkdir -p";
 	catt = "bat";
  grep = "grep --color=always";
  df = "df -h";

  #yadm
  ya = "yadm add";
  yc = "yadm commit; yadm push";
  ys = "yadm status";

  # restarty i wylaczanie
 	rebootsafe = "sudo shutdown -r now";
 	rebootforce = "sudo shutdown -r -n now";
 	shutdown = "sudo shutdown";

 	home = "cd ~";

  sduo = "sudo";
  suod = "sudo";
  sz = "source ~/.config/zsh/.zshrc";
  };

  #programs.starship = {
  #  enable = true;
  #  settings = {
  #    # sprawdz ustawienia starship
  #  };
  #};
  
  home.file = {
  };

  #xdg.userDirs = {
 # 	enable = true;
 # 	createDirectories = true;
 # };

  home.sessionVariables = {
    EDITOR = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
