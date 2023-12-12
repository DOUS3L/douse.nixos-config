{ config, pkgs, unstable, host, ... }:

{
  imports = [
    ../modules/alacritty/home.nix
    ../modules/wezterm/home.nix
    ../modules/rofi/home.nix
    ../modules/zsh/home.nix
    ../modules/helix/home.nix
    ../modules/neovim/home.nix
    ../modules/tmux/home.nix
    ../modules/lf/home.nix
  ];

  

  xdg = {
    enable = true;
  };

  # need to enable sops-nix service manually
  # systemctl --user start sops-nix.service
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
    secrets = {
      douse_ed25519_private_ssh_key = {
        path = "${config.home.homeDirectory}/.ssh/douse_ed25519";
        mode = "0600";
      };
      douse_ed25519_public_ssh_key = {
        path = "${config.home.homeDirectory}/.ssh/douse_ed25519.pub";
      };
    };
  };

  home = {

    file = {
      "wallpapers" = {
        enable = true;
        source = ../files/wallpapers;
        recursive = true;
        target = "wallpapers";
      };
    };

    packages = with pkgs; [
      # terminal
      unstable.xplr
      jq
      unstable.yt-dlp

      # video/audio
      feh
      mpv
      pavucontrol
      vlc

      # apps
      appimage-run
      bitwarden
      unstable.firefox
      unstable.floorp
      # unstable.sublime4
      unstable.motrix
      unstable.tartube-yt-dlp
      unstable.qbittorrent


      # file management
      okular
      p7zip
      rsync
      unzip
      unrar
      zip
      ntfs3g
      exfat

    ];


    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
        "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
        "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "dhdgffkkebhmkfjojejmpbldmpobfkfo" # tampermonkey
        "akiljllkbielkidmammnifcnibaigelm" # webtoepub
      ];
    };
  };

  services = {
    flameshot = {
      enable = true;
      package = unstable.flameshot;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
  };
}
