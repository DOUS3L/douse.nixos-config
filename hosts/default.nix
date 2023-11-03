{ lib, inputs, nixpkgs, nixpkgs-unstable, user, oceanedge-user, bluewheels-user, home-manager, sops-nix, nixos-wsl, multiwsl2-user, ... }:

let
  system = "x86_64-linux";

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

in
{
  # zephyrus ga402rk config
  zephyrus = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable oceanedge-user bluewheels-user nixpkgs-unstable;
      host = {
        hostName = "zephyrus";
      };
    };


    modules = [
      ./zephyrus
      ./configuration.nix
      ../profiles/aldouse
      ../profiles/oceanedge
      ../profiles/bluewheels

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit unstable user oceanedge-user bluewheels-user;
          host = {
            hostName = "zephyrus";
          };
        };

        home-manager.users.${user} = {
          imports =
            [ (import ../profiles/${user}/home.nix) ]
            ++ [ (import ./home.nix) ]
            ++ [ (import ./zephyrus/home.nix) ]
          ;
        };

        home-manager.users.${oceanedge-user} = {
          imports =
            [ (import ../profiles/${oceanedge-user}/home.nix) ]
            ++ [ (import ./home.nix) ]
            ++ [ (import ./zephyrus/home.nix) ]
          ;
        };

        home-manager.users.${bluewheels-user} = {
          imports =
            [ (import ../profiles/${bluewheels-user}/home.nix) ]
            ++ [ (import ./home.nix) ]
            ++ [ (import ./zephyrus/home.nix) ]
          ;
        };

        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };

  # zg14-wsl2 config
  zg14-wsl2 = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable multiwsl2-user nixpkgs-unstable;
      host = {
        hostName = "zg14-wsl2";
      };
    };

    modules = [
      ./zg14-wsl2
      ../profiles/multi-wsl2

      nixos-wsl.nixosModules.wsl {
        wsl.enable = true;
        wsl.defaultUser = "${multiwsl2-user}";
      }

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit unstable user multiwsl2-user;
          host = {
            hostName = "zg14-wsl2";
          };
        };

        home-manager.users.${multiwsl2-user} = {
          imports =
            [ (import ../profiles/${multiwsl2-user}/home.nix) ]
            ++ [ (import ./zg14-wsl2/home.nix) ]
          ;
        };

        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };

  # virtualbox config
  virtualbox = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable oceanedge-user bluewheels-user;
    };

    modules = [
      ./virtualbox
      ./configuration.nix
      ../profiles/aldouse
      ../profiles/oceanedge
      ../profiles/bluewheels

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit unstable oceanedge-user bluewheels-user;
        };

        home-manager.users.${oceanedge-user} = {
          imports =
            [ (import ../profiles/${oceanedge-user}/home.nix) ]
            ++ [ (import ./home.nix) ]
            ++ [ (import ./virtualbox/home.nix) ]
          ;
        };

        home-manager.users.${bluewheels-user} = {
          imports =
            [ (import ../profiles/${bluewheels-user}/home.nix) ]
            ++ [ (import ./home.nix) ]
            ++ [ (import ./virtualbox/home.nix) ]
          ;
        };

        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };
}
