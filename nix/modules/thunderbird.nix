{ config, pkgs, ...}

  let
    lock-flase = {
      Value = false;
      Status = "locked"
    };
    lock-true = {
      Value = true;
      Status = "locked"
    };
  in
{
  programs = {
    thunderbird = {
      enable = true;
    };
  }; 
}
