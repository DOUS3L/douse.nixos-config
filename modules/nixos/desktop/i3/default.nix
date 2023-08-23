{ pkgs, lib, unstable, ... }:

{
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = unstable.i3;
    };

  };
}
