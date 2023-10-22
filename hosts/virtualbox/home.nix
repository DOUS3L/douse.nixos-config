{ ... }:
{
  imports = [
    ../../modules/i3/home.nix
  ];

  programs = {
    zsh = {
      shellAliases = {
        nrb = "cd ~/repos/douse.nixos-config && sudo nixos-rebuild switch --flake .#virtualbox";
      };
    };
  };
}
