{ user, pkgs, ... }:
{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    home = "/home/${user}";
  };
}
