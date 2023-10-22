{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/i3/default.nix
    ../../modules/vscode-server/default.nix
  ];

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHckmtE1O2lxeUqbgt1FgQdQ/+XG0uP3o94M0jUlahMu aldous@DESKTOP-6DKK2HM"
    ];

  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        configurationLimit = 10;
      };
    };
  };

  networking.networkmanager.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  services = {
    openssh.enable = true;
    vscode-server.enable = true;
    xserver = {
      layout = "us";
      resolutions = [
        { x = 1440; y = 900; }
      ];
    };
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
}
