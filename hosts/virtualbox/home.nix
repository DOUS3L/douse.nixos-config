{ ... }:
{
  imports = [
    ../../modules/home-manager/desktop/i3/home.nix
    ../../modules/home-manager/services/polybar.nix
  ];

  programs = {
    zsh = {
      shellAliases = {
        nrb = "cd ~/repos/douse.nixos-config && sudo nixos-rebuild switch --flake .#virtualbox";
      };
    };
  };
}
