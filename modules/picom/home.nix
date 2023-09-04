{ pkgs, home, ...}:
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
    settings = {
      blur = {
        method = "gaussian";
        deviation = 20;
        size = 20;
        strength = 5;
      };
      use-damage = true;
    };
  };
}