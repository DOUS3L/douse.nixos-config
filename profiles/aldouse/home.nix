{ user , ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
}
