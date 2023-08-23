{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ../../files/dotconfig/polybar/config.ini;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };
    script = "polybar &";
    extraConfig = (builtins.readFile ../../files/dotconfig/polybar/modules.ini) ;
  };
}
