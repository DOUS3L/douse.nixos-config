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

      # luajitPackages.luarocks
      # luajitPackages.luacheck

      stylua

      # for astronvim nix pack
      alejandra
      deadnix
      statix

    ];

    file = {
      # ".config/astronvim" = {
      #   enable = true;
      #   source = link ./astronvim;
      #   recursive = true;
      #   target = ".config/astronvim";
      # };
      # ".config/nvim-astronvim/lua" = {
      #   enable = true;
      #   source = link ./nvim-astronvim/lua;
      #   recursive = true;
      #   target = ".config/nvim-astronvim/lua";
      # };
      # ".config/nvim-astronvim/init.lua" = {
      #   enable = true;
      #   source = link ./nvim-astronvim/init.lua;
      #   # recursive = true;
      #   target = ".config/nvim-astronvim/init.lua";
      # };
      ".config/nvim/lua" = {
        enable = true;
        source = link ./nvim-astronvim/lua;
        recursive = true;
        target = ".config/nvim/lua";
      };
      ".config/nvim/init.lua" = {
        enable = true;
        source = link ./nvim-astronvim/init.lua;
        # recursive = true;
        target = ".config/nvim/init.lua";
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
    # zsh.shellAliases = {
    #   astronvim = "NVIM_APPNAME=nvim-astronvim nvim";
    # };
  };

  # xdg.configFile.nvim.source = pkgs.fetchFromGitHub {
  #   owner = "AstroNvim";
  #   repo = "AstroNvim";
  #   rev = "v3.37.9";
  #   sha256 = "sha256-b8fRxvehTD5nrygFp7180IQHpRmCm6t/E6RJ2nSO3m4=";
  # };
}
