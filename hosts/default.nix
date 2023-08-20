{ lib, inputs, nixpkgs, nixpkgs-unstable, user, home-manager, ... }:

let
  system = "x86_64-linux";

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  virtualbox = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user;
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
            [ (import ./home.nix) ] ++
            [ (import ./vm/home.nix) ]
          ;
        };
      }
    ];
  };
}
