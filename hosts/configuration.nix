{ user, pkgs, inputs, config, ... }:

{

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [
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
      ];
    })
  ];

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shells = [ pkgs.zsh ];
    systemPackages = with pkgs; [
      age
      fzf
      killall
      nano
      pciutils
      usbutils
      inetutils
      sops
      wget
      xclip
      # TODO: separate later
      neovim
      git
      nil
      nixpkgs-fmt
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
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
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
