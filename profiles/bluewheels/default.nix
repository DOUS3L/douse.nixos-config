{ bluewheels-user, pkgs, ... }:
{
  users.users.${bluewheels-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    home = "/home/${bluewheels-user}";
  };
}
