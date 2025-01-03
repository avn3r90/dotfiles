{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    plugins = [
      # Wbudowane pluginy z Nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      #{ name = "bobthefisher"; src = pkgs.fishPlugins.bobthefisher.src; }
      # Nowe pluginy
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }

      # Ręcznie dodany plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };
}
