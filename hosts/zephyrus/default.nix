{ pkgs, unstable, nixpkgs-unstable, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/i3/default.nix
    ../../modules/input-remapper/default.nix
    ../../modules/fcitx5/default.nix
  ];


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

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;

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

  networking.hostName = "zephyrus";
  networking.firewall.checkReversePath = "loose";
  networking.wireguard.enable = true;
  networking.networkmanager.enable = true;

  environment = {
    extraInit = ''
      xset s off -dpms
      xset s noblank
    '';
    systemPackages = [
      pkgs.acpi
      pkgs.powertop
      # pkgs.asusctl
      pkgs.cpufrequtils
      pkgs.arandr
      pkgs.brightnessctl
      pkgs.powerstat
      pkgs.pamixer
    ];
  };


  programs = {
    noisetorch = {
      enable = true;
      package = unstable.noisetorch;
    };
  };

  services = {
    autorandr = {
      enable = true;
      profiles = {
        "room" = {
          fingerprint = {
            eDP-2 = "00ffffffffffff0051b88114000000001d1f0104a51e1378070f91ae5243b0260f505400000001010101010101010101010101010101c0d800a0a04064602b2075042dbc10000018606c00a0a04064602b2075042dbc10000018000000fd003078cece38010a202020202020000000fc00544c3134304144585030310a200093";
            HDMI-1-1 = "00ffffffffffff0005e3022726000000311e0103803c22782ab3e5ac5048a426115054bfef00d1c081803168317c4568457c6168617c565e00a0a0a029503020350055502100001e40e7006aa0a067500820980455502100001a000000fc00513237473247340a2020202020000000fd0030901ee63c000a2020202020200149020330f14c101f0514041303120211013f230907078301000065030c00100067d85dc401788000681a000001013090e66fc200a0a0a055503020350055502100001e5aa000a0a0a046503020350055502100001e023a801871382d40582c450055502100001ef03c00d051a0355060883a0055502100001c00000000000000fd";
          };
          config = {
            eDP-2 = {
              enable = true;
              crtc = 0;
              mode = "2560x1600";
              position = "0x0";
              primary = true;
              rate = "120.00";
            };
            HDMI-1-1 = {
              enable = true;
              crtc = 4;
              mode = "2560x1440";
              position = "2560x80";
              primary = false;
              rate = "96.00";
            };
          };
        };
        "room2" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0051b88114000000001d1f0104a51e1378070f91ae5243b0260f505400000001010101010101010101010101010101c0d800a0a04064602b2075042dbc10000018606c00a0a04064602b2075042dbc10000018000000fd003078cece38010a202020202020000000fc00544c3134304144585030310a200093";
            HDMI-1-1 = "00ffffffffffff0005e3022726000000311e0103803c22782ab3e5ac5048a426115054bfef00d1c081803168317c4568457c6168617c565e00a0a0a029503020350055502100001e40e7006aa0a067500820980455502100001a000000fc00513237473247340a2020202020000000fd0030901ee63c000a2020202020200149020330f14c101f0514041303120211013f230907078301000065030c00100067d85dc401788000681a000001013090e66fc200a0a0a055503020350055502100001e5aa000a0a0a046503020350055502100001e023a801871382d40582c450055502100001ef03c00d051a0355060883a0055502100001c00000000000000fd";
          };
          config = {
            eDP-1 = {
              enable = true;
              crtc = 0;
              mode = "2560x1600";
              position = "0x0";
              primary = true;
              rate = "120.00";
            };
            HDMI-1-1 = {
              enable = true;
              crtc = 4;
              mode = "2560x1440";
              position = "2560x80";
              primary = false;
              rate = "96.00";
            };
          };
        };
        "roam" = {
          fingerprint = {
            eDP-2 = "00ffffffffffff0051b88114000000001d1f0104a51e1378070f91ae5243b0260f505400000001010101010101010101010101010101c0d800a0a04064602b2075042dbc10000018606c00a0a04064602b2075042dbc10000018000000fd003078cece38010a202020202020000000fc00544c3134304144585030310a200093";
          };
          config = {
            eDP-2 = {
              enable = true;
              crtc = 0;
              mode = "2560x1600";
              position = "0x0";
              primary = true;
              rate = "60.00";
              # dpi = 120;
            };
          };
        };
        "roam2" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0051b88114000000001d1f0104a51e1378070f91ae5243b0260f505400000001010101010101010101010101010101c0d800a0a04064602b2075042dbc10000018606c00a0a04064602b2075042dbc10000018000000fd003078cece38010a202020202020000000fc00544c3134304144585030310a200093";
          };
          config = {
            eDP-1 = {
              enable = true;
              crtc = 0;
              mode = "2560x1600";
              position = "0x0";
              primary = true;
              rate = "60.00";
              # dpi = 120;
            };
          };
        };
      };
    };
    ## battery / performance management related
    acpid.enable = true;
    # asusd = {
    #   enable = true;
    #   enableUserService = true;
    # };
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "never";
        };
        battery = {
          governor = "performance";
          turbo = "never";
          # scaling_max_freq = "2200000";
        };
      };
    };
    # power-profiles-daemon.enable = true;
    tlp = {
      enable = true;
      settings = {
        # battery
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 60;

        # graphics
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        RADEON_DPM_STATE_ON_BAT = "battery";

        # platform
        PLATFORM_PROFILE_ON_BAT = "quiet";

        # processor
        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_MIN_FREQ_ON_AC = 400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 3300000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1800000;

        # sound
        # disabling this because it causes static
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;

        # runtime and ASPM
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

      };
    };

    openssh.enable = true;
    mullvad-vpn.enable = true;
    supergfxd.enable = true;
    xserver = {
      dpi = 120;
      upscaleDefaultCursor = true;
      layout = "us";
      # resolutions = [
      #   { x = 2560; y = 1600; }
      # ];
    };


  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

  virtualisation = {
    # podman = {
    #   enable = true;
    #   # Create a `docker` alias for podman, to use it as a drop-in replacement
    #   dockerCompat = true;
    #   # Required for containers under podman-compose to be able to talk to each other.
    #   defaultNetwork.settings.dns_enabled = true;
    # };
    docker = {
      enable = true;
      package = unstable.docker;
      enableOnBoot = false;
      # rootless = {
      #   enable = true;
      #   package = unstable.docker;
      #   setSocketVariable = true;
      # };
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  # systemd.services.kill-running-openvpn = {
  #   script = ''
  #     for s in `systemctl | grep openvpn | cut -d '.' -f 1`; do echo stopping $s && systemctl stop $s; done
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };
}
