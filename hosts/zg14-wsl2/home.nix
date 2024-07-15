{ config, pkgs, unstable, host, ... }:

{
  imports = [
    ../../modules/zsh/home.nix
    ../../modules/helix/home.nix
    ../../modules/neovim/home.nix
    ../../modules/tmux/home.nix
    ../../modules/lf/home.nix
  ];

  xdg = {
    enable = true;
  };

  # need to enable sops-nix service manually
  # systemctl --user start sops-nix.service
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
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
    packages = with pkgs; [
      jq
      rsync
      unzip
      unrar
      zip
    ];

    stateVersion = "24.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
