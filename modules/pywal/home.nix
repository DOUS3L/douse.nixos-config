{ pkgs, unstable, home, ... }:
{

  home = {
    packages = with pkgs; [ pywal ];
    file = {
      "wal" = {
        enable = true;
        source = ./wal;
        recursive = true;
        target = ".config/wal";
      };
    };
  };
}
