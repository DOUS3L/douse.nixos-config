{ pkgs, lib, unstable, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3blocks
        ];
        package = unstable.i3;
      };
    };


  };
}
