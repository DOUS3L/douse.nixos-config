{ user, pkgs, unstable, lib, inputs, config, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];
  # users.users.${user} = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" "networkmanager" ];
  #   shell = pkgs.zsh;
  #   home = "/home/${user}";
  # };

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
      nano
      nil
      nixpkgs-fmt
      pciutils
      sops
      stdenv
      sysstat
      usbutils
      wget
      wirelesstools
      xclip
      xorg.xdpyinfo

      unstable.android-file-transfer
      unstable.jmtpfs
      unstable.go-mtpfs
    ];
  };

  programs = {
    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    # MIGHTDO: move this later for astrovim
    neovim = {
      enable = true;
    };
    # nm-applet = {
    #   enable = true;
    #   indicator = false;
    # };
    zsh.enable = true;
  };

  services = {
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # universal logseq vault
  # system.activationScripts.makeLogseqVaultDirectory = lib.stringAfter [ "var" ] ''
  #   mkdir -p /var/lib/logseq.vault.d
  #   chmod --recursive 777 /var/lib/logseq.vault.d
  # '';


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
  nixpkgs.config.allowUnfree = true;

  system = {
    stateVersion = "23.05";
  };
}
