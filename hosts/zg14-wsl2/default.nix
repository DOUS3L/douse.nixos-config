{ multiwsl2-user, pkgs, unstable, lib, inputs, config, ... }:

{

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "zg14-wsl2";


  time.timeZone = "Asia/Jakarta";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  fonts = {
    packages = with pkgs; [
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
      HOSTNAME = "zg14-wsl2";
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
      nano
      nil
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
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];
  };

  system = {
    stateVersion = "24.05";
  };
}
