{ pkgs, config, ... }:
{
  services.dunst = {
    enable = true;
    configFile = "${config.home.homeDirectory}/.cache/dunstrc_v2";
  };
}