{ config, pkgs, unstable, ... }:
let
  modifier = "Mod4";
  modeSystem = "s: suspend, l: logout, r: reboot, p: poweroff";

  ws1 = "1:「一」";
  ws2 = "2:「二」";
  ws3 = "3:「三」";
  ws4 = "4:「四」";
  ws5 = "5:「五」";
  ws6 = "6:「六」";
  ws7 = "7:「七」";
  ws8 = "8:「八」";
  ws9 = "9:「九」";
  ws10 = "10:「十」";
in
{
  # theming with pywal
  imports = [
    ../pywal/home.nix
  ];

  home = {
    packages = with pkgs; [
      i3wsr
      # pkgs.python311 # needed for i3blocks
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

        assigns = {
          "$ws7" = [{ class = "Sublime_text"; }];
          "$ws8" = [{ class = "Spotify"; }];
          "$ws9" = [{ class = "Slack"; } { class = "discord"; }];
          "$ws10" = [{ class = "firefox"; } { title = "^Mozilla Firefox$"; } { class = "Vivaldi-stable"; }];
        };

        bars = [
          {
            command = "i3bar --transparency";
            statusCommand = "i3blocks";
            fonts = {
              names = [ "IosevkaTerm Nerd Font" ];
              size = 11.0;
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
            extraConfig = "strip_workspace_numbers yes\n";
          }
        ];

        gaps = {
          inner = 4;
          outer = 0;
        };

        keycodebindings = {
          # volumes
          "123" = "exec ${pkgs.pamixer}/bin/pamixer -i 5 && ${pkgs.dunst}/bin/dunstify VOLUME -h int:value:$(pamixer --get-volume) -i audio-volume-high";
          "122" = "exec ${pkgs.pamixer}/bin/pamixer -d 5 && ${pkgs.dunst}/bin/dunstify VOLUME -h int:value:$(pamixer --get-volume) -i audio-volume-high";
        };

        keybindings = {
          # apps keybind
          ## alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          ## flameshot 
          "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
          ## rofi
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -config ~/.config/rofi/launcher2.rasi";
          "${modifier}+Tab" = "exec ${pkgs.rofi}/bin/rofi -show window -config ~/.config/rofi/launcher2.rasi";
          ## pavucontrol
          "${modifier}+v" = ''[instance="pavucontrol"] scratchpad show, move position center'';
          ## floating alacritty
          "${modifier}+t" = ''[instance="floatingterm"] scratchpad show, move position center'';
          ## brightness control
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%+";

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

          # modes
          "${modifier}+r" = "mode resize";
          "${modifier}+Shift+e" = ''mode "${modeSystem}"'';

          # workspaces
          # switch to workspace
          "${modifier}+1" = "workspace number $ws1";
          "${modifier}+2" = "workspace number $ws2";
          "${modifier}+3" = "workspace number $ws3";
          "${modifier}+4" = "workspace number $ws4";
          "${modifier}+5" = "workspace number $ws5";
          "${modifier}+6" = "workspace number $ws6";
          "${modifier}+7" = "workspace number $ws7";
          "${modifier}+8" = "workspace number $ws8";
          "${modifier}+9" = "workspace number $ws9";
          "${modifier}+0" = "workspace number $ws10";

          # move focused container to workspace
          "${modifier}+Shift+1" = "move container to workspace number $ws1";
          "${modifier}+Shift+2" = "move container to workspace number $ws2";
          "${modifier}+Shift+3" = "move container to workspace number $ws3";
          "${modifier}+Shift+4" = "move container to workspace number $ws4";
          "${modifier}+Shift+5" = "move container to workspace number $ws5";
          "${modifier}+Shift+6" = "move container to workspace number $ws6";
          "${modifier}+Shift+7" = "move container to workspace number $ws7";
          "${modifier}+Shift+8" = "move container to workspace number $ws8";
          "${modifier}+Shift+9" = "move container to workspace number $ws9";
          "${modifier}+Shift+0" = "move container to workspace number $ws10";

          # Move workspaces betweeen monitors
          "${modifier}+Control+h" = "move workspace to output left";
          "${modifier}+Control+j" = "move workspace to output down";
          "${modifier}+Control+k" = "move workspace to output up";
          "${modifier}+Control+l" = "move workspace to output right";

        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode default";
        };

        modes."${modeSystem}" = {
          "r" = "exec --no-startup-id systemctl reboot";
          "s" = "exec --no-startup-id systemctl suspend; mode default";
          "l" = "exit";
          "p" = "exec --no-startup-id systemctl poweroff";
          "Escape" = "mode default";
        };

        startup = [
          #{
          #  command = "${pkgs.feh}/bin/feh --randomize --bg-fill ${config.home.homeDirectory}/wallpapers/*";
          #  always = true;
          #  notification = false;
          #}
          {
            command = "${pkgs.alacritty}/bin/alacritty --class floatingterm &";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.pywal}/bin/wal -i ~/wallpapers";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.picom}/bin/picom -b";
            always = false;
            notification = false;
          }
          {
            command = "pkill dunst";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.i3wsr}/bin/i3wsr";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.pavucontrol}/bin/pavucontrol &";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.autorandr}/bin/autorandr -c && ${pkgs.pywal}/bin/wal -i ~/wallpapers";
            always = false;
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
            {
              command = "floating enable, resize set 800 800, move scratchpad";
              criteria = { instance = "pavucontrol"; class = "Pavucontrol"; };
            }
          ];
          titlebar = false;
        };


      };
      # mostly settings for pywal
      extraConfig = ''
        # workspace numbers
        set $ws1 ${ws1} 
        set $ws2 ${ws2} 
        set $ws3 ${ws3} 
        set $ws4 ${ws4} 
        set $ws5 ${ws5} 
        set $ws6 ${ws6} 
        set $ws7 ${ws7} 
        set $ws8 ${ws8} 
        set $ws9 ${ws9} 
        set $ws10 ${ws10} 

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
        set_from_resource $bg_alt i3wm.color

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
