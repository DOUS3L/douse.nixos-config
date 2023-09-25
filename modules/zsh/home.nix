{ pkgs, unstable, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      #      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history.size = 100000;
      shellAliases = {
        sctl = "systemctl";
      };
      initExtra = ''
        source ${unstable.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # Navigation with ranger-fm
        ranger_cd() {
          temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
          ranger --choosedir="$temp_file" -- "''${@:-$PWD}"
          if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
              cd -- "$chosen_dir"
          fi
          rm -f -- "$temp_file"
        }

        bindkey -s '^o' 'ranger_cd\n'

        (cat ~/.cache/wal/sequences &)
      '';

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
      ];
    };
  };
}
