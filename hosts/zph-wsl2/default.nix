{ user, pkgs, unstable, lib, inputs, config, ... }:

{
  imports = [
    ../../modules/vscode-server/default.nix
  ];
  networking.hostName = "zph-wsl2";

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Asia/Jakarta";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "ja_JP.utf8";
    };
  };

  fonts = {
    fonts = with pkgs; [
      carlito
      vegur
      source-code-pro
      jetbrains-mono
      font-awesome
      corefonts
      meslo-lgs-nf
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "Hack"
          "DroidSansMono"
          "Meslo"
          "Hack"
          "Iosevka"
          "IosevkaTerm"
          "JetBrainsMono"
          "ComicShannsMono"
          "CodeNewRoman"
          "FantasqueSansMono"
        ];
      })
    ];
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shells = [ pkgs.zsh ];
    systemPackages = with pkgs; [
      age
      cargo
      coreutils-full
      font-manager
      fzf
      gcc
      gcc-unwrapped
      git
      glib
      gnumake
      gnupg
      inetutils
      iw
      killall
      nixpkgs-fmt
      pciutils
      sops
      stdenv
      sysstat
      wget
      xclip
    ];
  };
    
  programs = {
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    neovim = {
      enable = true;
    };
    zsh.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

  virtualisation = {
    docker = {
      enable = true;
      package = unstable.docker;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  system = {
    stateVersion = "23.05";
  };
}
