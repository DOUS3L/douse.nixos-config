
{ pkgs, unstable, ... }:
{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        cursor = {
          style = {
            shape = "Underline";
            blinking = "One";
          };
          vi_mode_style.shape = "Underline";
        };
        env = {
          TERM = "xterm-256color";
        };
        font = {
          normal = {
            family = "LigaSFMonoNerdFont";
            style = "Medium";
          };
        };
        window = {
          opacity = 0.84;
          padding.x = 3;
        };
      };
    };
  };
}
