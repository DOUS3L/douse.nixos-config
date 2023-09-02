
{ pkgs, unstable, home, ... }:
{

  home = {
    file = {
      "rofi" = {
        enable = true;
        source = ./rofi;
        recursive = true;
        target = ".config/rofi";
      };
    };
  };
  programs = {
    rofi = {
      enable = true;
    };
  };
}