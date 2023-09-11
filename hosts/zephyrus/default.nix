{ pkgs, unstable, ... }:

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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  networking.networkmanager.enable = true;

  environment = {
    systemPackages = [
      pkgs.acpi
      pkgs.powertop
      pkgs.asusctl
    ];
  };



  services = {
    acpid.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
      # asusdConfig = ''
      #   (
      #     bat_charge_limit: 80,
      #     panel_od: false,
      #     disable_nvidia_powerd_on_battery: true,
      #     ac_command: "",
      #     bat_command: "",
      #   )
      # '';
      # profileConfig = ''
      #   (
      #     active_profile: Quiet,
      #   )
      # '';
    };
    openssh.enable = true;
    mullvad-vpn.enable = true;
    power-profiles-daemon.enable = true;
    supergfxd.enable = true;
    xserver = {
      dpi = 120;
      upscaleDefaultCursor = true;
      layout = "us";
      resolutions = [
        { x = 2560; y = 1600; }
      ];
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

}
