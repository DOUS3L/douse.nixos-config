{ pkgs, home, ... }:
{
  services.picom = {
    enable = true;
    backend = "glx";
    opacityRules = [
      "98:class_g = 'Alacritty'"
      "100:class_g = 'firefox'"
    ];
    wintypes = {
      normal = {
        blur-background = true;
      };
      splash = {
        blur-background = false;
      };
    };
    # shadow = true;
    # shadowOffsets = [ (-3) (-3) ];
    settings = {
      blur = {
        method = "dual_kawase";
        deviation = 20;
        size = 20;
        strength = 5;
      };
      use-damage = true;
      # shadow-radius = 7;
    };
  };
}
