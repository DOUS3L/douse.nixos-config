{ config, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    file = {
      ".config/input-remapper/config.json" = {
        enable = true;
        source = link ./config.json;
        target = ".config/input-remapper/config.json";
      };
      ".config/input-remapper/presets/ROYUAN OLV75/default.json" = {
        enable = true;
        source = link ./presets/ROYUAN-OLV75/default.json;
        target = ".config/input-remapper/presets/ROYUAN OLV75/default.json";
      };
    };
  };
}
