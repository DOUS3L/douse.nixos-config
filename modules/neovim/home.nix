{ pkgs, config, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      # astronvim extra requirements
      ripgrep
      lazygit
      nodejs

      # gui neovim
      neovide

    ];

    file = {
      ".config/astronvim" = {
        enable = true;
        source = link ./astronvim;
        recursive = true;
        target = ".config/astronvim";
      };
    };
  };

  programs = {
    git.extraConfig.core.editor = "nvim";
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  xdg.configFile.nvim.source = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v3.36.6";
    sha256 = "sha256-XbvqX7xEdgfS8/fNvkwB4x7SW4S/Myh3MJS8TH70Xs0=";
  };
}
