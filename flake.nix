{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, nixos-wsl, ... }:
    let
      # default user
      user = "aldouse";
      oceanedge-user = "oceanedge";
      bluewheels-user = "bluewheels";
      multiwsl2-user = "multi-wsl2";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit user oceanedge-user bluewheels-user inputs nixpkgs nixpkgs-unstable home-manager sops-nix multiwsl2-user nixos-wsl;
        }
      );
    };
}
