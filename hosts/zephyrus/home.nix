{ ... }:
{
  imports = [
    ../../modules/i3/home.nix
    ../../modules/picom/home.nix
    ../../modules/dunst/home.nix
  ];

  programs = {
    alacritty = {
      settings = {
        env = {
          WINIT_X11_SCALE_FACTOR = "1.5";
        };
      };
    };
  };

  programs = {
    zsh = {
      shellAliases = {
        killvpn = "for s in `systemctl | grep openvpn | cut -d '.' -f 1`; do  echo stopping $s && sudo systemctl stop $s; done";
      };
    };
  };


}
