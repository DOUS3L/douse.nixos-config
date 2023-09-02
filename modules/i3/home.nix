{ config, pkgs, unstable, ... }:
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
  # theming with pywal
  imports = [
    ../pywal/home.nix
  ];

  home = {
    packages = with pkgs; [
      dunst
    ];
    file = {
      "i3blocks" = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ./i3blocks;
        recursive = true;
        target = "./.config/i3blocks";
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
            command = "i3bar --transparency";
            statusCommand = "i3blocks";
            fonts = {
              names = ["MesloLGS NF"];
              size = 10.0;
            };
            # extraConfig = "separator_symbol \" / \" \n";
            colors = {
              background = "$color0";
              focusedWorkspace = {
                border = "$color3";
                background = "$color1";
                text = "$color7";
              };
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
          {
            command = "${pkgs.pywal}/bin/wal -i ~/wallpapers --backend random";
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
      # mostly settings for pywal
      extraConfig = ''
      set_from_resource $color0 i3wm.color0 #f0f0f0
      set_from_resource $color1 i3wm.color1 #f0f0f0
      set_from_resource $color2 i3wm.color2 #f0f0f0
      set_from_resource $color3 i3wm.color3 #f0f0f0
      set_from_resource $color4 i3wm.color4 #f0f0f0
      set_from_resource $color5 i3wm.color5 #f0f0f0
      set_from_resource $color6 i3wm.color6 #f0f0f0
      set_from_resource $color7 i3wm.color7 #f0f0f0
      set_from_resource $color8 i3wm.color8 #f0f0f0

      set_from_resource $fg i3wm.color3 #f0f0f0
      set_from_resource $bg i3wm.color8 #f0f0f0

      set_from_resource $fg i3wm.color3 #f0f0f0
      set_from_resource $bg i3wm.color8 #f0f0f0

      # class                 border  backgr. text     indicator child_border
      client.focused          $fg     $fg     $color0  $fg       $fg
      client.focused_inactive $bg     $bg     $color0  $bg       $bg
      client.unfocused        $bg     $bg     $color0  $bg       $bg

      client.background       $bg

      set_from_resource $barcolor i3wm.color0
      '';
    };
  };
}
