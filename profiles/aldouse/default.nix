{ user, pkgs, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    home = "/home/${user}";
  };
}
