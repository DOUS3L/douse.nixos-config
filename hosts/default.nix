{ lib, inputs, nixpkgs, nixpkgs-unstable, user, oceanedge-user, bluewheels-user, home-manager, sops-nix, ... }:

let
  system = "x86_64-linux";

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

  nixos-wsl = {
    url = "github:nix-community/NixOS-WSL";
    inputs.nixpkgs.follows = "nixpkgs";
  };

in
{

  # zephyrus ga402rk config
  zephyrus = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable oceanedge-user bluewheels-user nixpkgs-unstable;
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

  # virtualbox config
  virtualbox = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable;
    };

    modules = [
      ./virtualbox
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit unstable user;
        };

        home-manager.users.${user} = {
          imports =
            [ (import ./home.nix) ]
            ++ [ (import ./virtualbox/home.nix) ]
          ;
        };

        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };

  # zph-wsl2 config
  zph-wsl2 = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user unstable;
    };

    modules = [
      ./zph-wsl2
      nixos-wsl.nixosModules.wsl

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit unstable user;
        };

        home-manager.users.${oceanedge-user} = {
          imports =
            [ (import ../profiles/${oceanedge-user}/home.nix) ]
            ++ [ (import ./zephyrus/home.nix) ]
          ;
        };

        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      }
    ];
  };
}
