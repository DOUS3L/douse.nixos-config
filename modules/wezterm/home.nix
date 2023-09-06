{ unstable, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    package = unstable.wezterm;
    extraConfig = ''
    config.window_background_opacity = 0.85
    '';
  };
}