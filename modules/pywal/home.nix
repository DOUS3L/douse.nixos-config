{ pkgs, unstable, home, ... }:
{
  home.packages = with pkgs; [ pywal ];
}