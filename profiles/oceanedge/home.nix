
{ oceanedge-user, ... }:
{
  home = {
    username = "${oceanedge-user}";
    homeDirectory = "/home/${oceanedge-user}";
  };
}
