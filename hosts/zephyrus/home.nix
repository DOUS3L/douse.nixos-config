{ ... }:
{
  imports = [
    ../../modules/i3/home.nix
    ../../modules/picom/home.nix
    ../../modules/dunst/home.nix
  ];

  programs = {
    alacritty = {
      settings = {
        env = {
          WINIT_X11_SCALE_FACTOR = "1.5";
        };
      };
    };
  };



  #programs = {
  #  zsh = {
  #    shellAliases = {
  #      nrb = "cd ~/repos/douse.nixos-config && sudo nixos-rebuild switch --flake .#virtualbox";
  #    };
  #  };
  #};
}
