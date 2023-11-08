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
    rev = "v3.37.9";
    sha256 = "sha256-b8fRxvehTD5nrygFp7180IQHpRmCm6t/E6RJ2nSO3m4=";
  };
}
