{
  description = "A very basic flake";

  inputs = {  
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }: 
    let
      user = "aldouse";
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable user;
        }
      );
    };
}
