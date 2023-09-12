{ unstable, pkgs, ... }:
{
  home = {
    file = {
      "tmux_themes" = {
        enable = true;
        source = ./themes;
        recursive = true;
        target = ".config/tmux/themes";
      };
    };
  };

  programs = {
    tmux = {
      enable = true;
      package = pkgs.tmux;
      mouse = true;
      prefix = "C-a";
      plugins = with pkgs; [
        tmuxPlugins.extrakto
        # tmuxPlugins.nord
      ];
      extraConfig = ''
        # set terminal 256 color 
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",xterm-256color:Tc"
        set -sg terminal-overrides ",*:RGB"

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # switch panes using alt-vim keys without prefix
        bind -n M-h select-pane -L
        bind -n M-l select-pane -R
        bind -n M-k select-pane -U
        bind -n M-j select-pane -D
        
        source ~/.config/tmux/themes/srcery.conf
        source ~/.config/tmux/themes/srcery_no_patched.conf
      '';
    };
  };
}
