{ lib, inputs, nixpkgs, nixpkgs-unstable, user, ... }:

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
    ];
  };
}