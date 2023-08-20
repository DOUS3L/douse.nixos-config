{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      neovim 

      # astronvim extra requirements
      ripgrep
      lazygit
      nodejs

    ];
  };

  programs.git.extraConfig.core.editor = "nvim";

  xdg.configFile.nvim.source = pkgs.fetchFromGithub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v3.36.3";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
}