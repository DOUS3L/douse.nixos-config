{ pkgs, unstable, home, ... }:
{

  home = {
    packages = with pkgs; [ rofi ];
    file = {
      "rofi" = {
        enable = true;
        source = ./rofi;
        recursive = true;
        target = ".config/rofi";
      };
    };
  };
  # not using below config because it creates default config.rasi
  #programs = {
  #  rofi = {
  #    enable = true;
  #  };
  #};
}
