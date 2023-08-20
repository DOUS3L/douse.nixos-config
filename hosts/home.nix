{ pkgs, unstable, user, ... }:

{
  # imports

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
