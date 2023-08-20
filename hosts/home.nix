{ pkgs, unstable, user, ... }:

{
  # imports

  home = {
    username = "${user}";
    homeDirectory = "home/${user}";
  };

  programs = {
    home-manager.enable = true;
  };

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
    chromium
    ungoogled-chromium

    # file management
    okular
    p7zip
    rsync
    unzip
    unrar
    zip

  ];
}
