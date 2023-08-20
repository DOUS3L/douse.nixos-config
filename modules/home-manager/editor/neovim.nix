{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # astronvim extra requirements
      ripgrep
      lazygit
      nodejs

    ];
    file = {
      ".config/astronvim" = {
        enable = true;
        source = "../../../files/dotconfig/astronvim";
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
    rev = "v3.36.3";
    sha256 = "sha256-JmoiCZNR3XWucE6XsbTnY8HMiR1pxKAr/sdOTMIdfNA=";
  };
}