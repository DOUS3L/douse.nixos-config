{ pkgs, unstable, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        dynamic_padding = true;
        cursor = {
          style = {
            shape = "Underline";
            blinking = "On";
          };
          vi_mode_style.shape = "Underline";
        };
        colors = {
          transparent_background_colors = true;
        };
        env = {
          TERM = "xterm-256color";
        };
        font = {
          normal = {
            family = "FantasqueSansM Nerd Font";
          };
          size = 12.0;
        };
        window = {
          opacity = 0.84;
          padding.x = 1;
          padding.y = 0;
        };
      };
    };
  };
}
