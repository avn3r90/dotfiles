{ config, pkgs, ... }:

{
  home.username = "fi9o";
  home.homeDirectory = "/home/fi9o";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
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
    #pkgs.yadm

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
    #pkgs.qbittorrent
    #pkgs.stremio
    #pkgs.vlc
  ];

  imports = [
  	#./modules/zsh.nix
  	./modules/firefox.nix
  ];

    programs.zsh = {
		enable = true;
		autocd = true;
		autosuggestion.enable = true;
		#enableAutosuggestions = true;
		defaultKeymap = "viins";
		dotDir = ".config/zsh";
		history = {
			path = ".cache/zsh/history";
			save = 20000;
			size = 20000;
		};
		completionInit = ''
			autoload -Uz compinit
			compinit
		'';
		historySubstringSearch = {
			enable = true;
			searchDownKey = [ "^[[A" "^P" ];
			searchUpKey = [ "^[[B" "^N" ];
		};
		envExtra = '' 
			export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
			export PATH=$HOME/.local/bin:$HOME/.bin:$PATH
		'';
		initExtraBeforeCompInit = ''
			zstyle ':completion:*' completer _menu _expand _complete _correct _approximate
			zstyle ':completion:*' completions 0
			zstyle ':completion:*' glob 0
			zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
			zstyle ':completion:*' max-errors 10
			zstyle ':completion:*' special-dirs true
			zstyle ':completion:*' substitute 1
			zstyle :compinstall filename '/home/yusuf/.config/zsh/.zshrc'
		'';
	};

  home.shellAliases = {
  l = "eza -l --icons";
 	ls = "eza --icons";
 	ll = "eza -la --icons";
 	ld = "eza -lD --icons";
 	cp = "cp -i";
 	mv = "mv -i";
 	mkdir = "mkdir -p";
 	cat = "bat";
  grep = "grep --color=always";
  df = "df -h";

  # Alias's for safe and forced reboots
 	rebootsafe = "sudo shutdown -r now";
 	rebootforce = "sudo shutdown -r -n now";
 	shutdown = "sudo shutdown";

 	home = "cd ~";

  sduo = "sudo";
  suod = "sudo";
  sz = "source ~/.config/zsh/.zshrc";
  };

  programs.starship = {
    enable = true;
    settings = {
      # sprawdz ustawienia starship
    };
  };
  
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
