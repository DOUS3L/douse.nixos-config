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
      pkgs.cpufrequtils
      pkgs.linuxKernel.packages.linux_6_4.cpupower
      pkgs.arandr
      pkgs.brightnessctl
      pkgs.powerstat
    ];
  };


  # powerManagement.powertop.enable = true;

  services = {
    acpid.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "never";
        };
        battery = {
          governor = "schedutil";
          turbo = "never";
          scaling_max_freq = "2200000";
        };
      };
    };

    openssh.enable = true;
    mullvad-vpn.enable = true;
    #power-profiles-daemon.enable = true;
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

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # systemd.services.kill-running-openvpn = {
  #   script = ''
  #     for s in `systemctl | grep openvpn | cut -d '.' -f 1`; do echo stopping $s && systemctl stop $s; done
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };

}
