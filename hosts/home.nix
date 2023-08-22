{ config, pkgs, unstable, user, ... }:

{
  imports = (import ../modules/home-manager/shell) ++
    (import ../modules/home-manager/editor);

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
      };
      douse_ed25519_public_ssh_key = {
        path = "${config.home.homeDirectory}/.ssh/douse_ed25519.pub";
      };
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # terminal
      ranger

      # video/audio
      feh
      mpv
      pavucontrol
      vlc

      # apps
      appimage-run
      firefox
      vivaldi
      vivaldi-ffmpeg-codecs

      # file management
      okular
      p7zip
      rsync
      unzip
      unrar
      zip

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

}
