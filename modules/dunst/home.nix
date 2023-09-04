{ pkgs, config, ... }:
{
  services.dunst = {
    enable = true;
    configFile = "${config.xdg.cacheHome}/wal/dunstrc_v1";
  };
}