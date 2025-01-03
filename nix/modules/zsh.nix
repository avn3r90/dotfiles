{ config, pkgs, ... }:
{
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
		oh-my-zsh = {
		  enable = true;
		  plugins = [ "git" "thefuck" ];
		  theme = "lukerandall";
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
}
