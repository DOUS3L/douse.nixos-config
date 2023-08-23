{ config, pkgs, ... }:
let
  modifier = "Mod4";
  workspace = {
    terminal = "terminal";
    code = "code";
    browser = "browser";
    spotify = "spotify";
    discord = "discord";
    bitwarden = "bitwarden";
    signal = "signal";
    extra-1 = "1";
    extra-2 = "2";
  };
in
{
  home = {
    packages = with pkgs; [
      dunst
    ];
    file = {
      "i3blocks" = {
        enable = true;
        source = ../../../../files/dotconfig/i3blocks;
        recursive = true;
        target = "./config/i3blocks";
      };
    };
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        inherit modifier;

        bars = [
          {
            statusCommand = "i3blocks";
            fonts = {
              names = ["Meslo Nerd Font"];
              size = 10.0;
            };
          }
        ];

        gaps = {
          inner = 4;
          outer = 0;
        };

        keybindings = {
          # apps keybind
          ## alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          ## flameshot 
          "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          # change focused window
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          # move focused window
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          # split in horizontal orientation
          "${modifier}+bar" = "split h";

          # split in vertial orientation
          "${modifier}+underscore" = "split v";

          # change container layout
          "${modifier}+Shift+w" = "layout tabbed";
          "${modifier}+Shift+s" = "layout toggle split";

          # toggle tiling / floating
          "${modifier}+Shift+space" = "floating toggle";

          # i3 specific commands
          "${modifier}+Shift+c" = "reload"; # reload configuration
          "${modifier}+Shift+r" = "restart"; # restart i3 inplace
          "${modifier}+Shift+q" = "kill"; # kill focused window
          "${modifier}+f" = "fullscreen toggle";

          # custom scripts
          "${modifier}+n" = "i3-msg workspace $(( $(i3-msg -t get_workspaces | jq '.[].num' | sort -rn | head -1) + 1 ))";

          # modes
          "${modifier}+r" = "mode resize";
          "${modifier}+Shift+e" = ''mode "(S)uspend, (L)ogout, (R)eboot, (P)oweroff"'';

        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode default";
        };

        modes."(S)uspend, (L)ogout, (R)eboot, (P)oweroff" = {
          "r" = "exec --no-startup-id systemctl reboot";
          "s" = "exec --no-startup-id systemctl suspend; mode default";
          "l" = "exit";
          "p" = "exec --no-startup-id systemctl poweroff";
          "Escape" = "mode default";
        };

        startup = [
          {
            command = "${pkgs.feh}/bin/feh --randomize --bg-fill ${config.home.homeDirectory}/wallpapers/*";
            always = true;
            notification = false;
          }
        ];

        window = {
          border = 2;
          commands = [
            {
              command = "floating enable, resize set 1400 800, border pixel 2, move scratchpad";
              criteria = { instance = "floatingterm"; };
            }
          ];
        };
        

      };
    };
  };
}
