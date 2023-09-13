{ pkgs, user, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = [
      pkgs.python311 # for i3blocks
    ];
  };

}
