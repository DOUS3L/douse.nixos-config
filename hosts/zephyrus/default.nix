{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/i3/default.nix
  ];
  networking.hostName = "zephyrus";


  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        useOSProber = true;
        configurationLimit = 15;
      };
    };
  };

  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true; 
  networking.networkmanager.enable = true;


  services = {
    openssh.enable = true;
    mullvad-vpn.enable = true;
    xserver = {
      dpi = 120;
      upscaleDefaultCursor = true;
      layout = "us";
      resolutions = [
        { x = 2560; y = 1600; }
      ];
    };
  };


}
