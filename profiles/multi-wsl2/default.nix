{ multiwsl2-user, pkgs, ... }:
{
  users.users.${multiwsl2-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    home = "/home/${multiwsl2-user}";
  };

}
