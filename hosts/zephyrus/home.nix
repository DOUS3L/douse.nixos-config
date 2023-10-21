{ unstable, ... }:
{
  imports = [
    ../../modules/i3/home.nix
    ../../modules/picom/home.nix
    ../../modules/dunst/home.nix
    ../../modules/input-remapper/home.nix
    ../../modules/fcitx5/home.nix
    ../../modules/vscode/home.nix
  ];

  programs = {
    alacritty = {
      settings = {
        env = {
          WINIT_X11_SCALE_FACTOR = "1.5";
        };
      };
    };
    zsh = {
      shellAliases = {
        rescanwifi = "nmcli device wifi rescan && nmcli device wifi list";
        killvpn = "for s in `systemctl | grep openvpn | cut -d '.' -f 1`; do  echo stopping $s && sudo systemctl stop $s; done";
      };
    };
  };

  # additional i3 configuration
  xsession.windowManager.i3.config.startup = [
    {
      command = "${unstable.input-remapper}/bin/input-remapper-control --command autoload";
      always = false;
      notification = false;
    }
  ];
}
