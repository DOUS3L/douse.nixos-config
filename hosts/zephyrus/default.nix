{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/i3/default.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        configurationLimit = 15;
      };
    };
  };

  networking.networkmanager.enable = true;

  services = {
    openssh.enable = true;
    xserver = {
      layout = "us";
      resolutions = [
        { x = 2560; y = 1440; }
      ];
    };
  };


}
