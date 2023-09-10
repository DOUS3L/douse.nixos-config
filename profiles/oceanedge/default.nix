{ oceanedge-user, pkgs, ... }:
{
  users.users.${oceanedge-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    home = "/home/${oceanedge-user}";
  };
}
