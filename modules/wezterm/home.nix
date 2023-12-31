{ unstable, ... }:
{
  programs.wezterm = {
    enable = true;
    package = unstable.wezterm;
    extraConfig = ''
      local config = {}
      config.window_background_opacity = 0.85
      config.use_fancy_tab_bar = false
      config.font_size = 16.0

      config.window_frame = {
        font = wezterm.font { family = 'IosevkaTerm' },
      }

      return config
    '';
  };
}
