{ unstable, ... }:
{
  programs = {
    tmux = {
      enable = true;
      package = unstable.tmux;
      extraConfigs = ''
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'laktak/extrakto'

        # set terminal 256 color 
        set -g default-terminal "screen-256color"
        set -sg terminal-overrides ",*:RGB"

        # set theme
        set -g @plugin 'srcery-colors/srcery-tmux'
        set -g @srcery_tmux_patched_font '1'

        # turn on mouse mode for scrolling
        set -g mouse on

        # change prefix to control+a
        set -g prefix C-a
        unbind C-b
        bind C-a send-prefix

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

        run '~/.tmux/plugins/tpm/tpm'
        '';
    }
  }
}
