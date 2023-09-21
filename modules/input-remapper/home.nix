{ ... }:
{
  home = {
    file = {
      ".config/input-remapper/config.json" = {
        enable = true;
        source = link ./input-remapper/config.json;
        target = ".config/input-remapper/config.json";
      };
      ".config/input-remapper/presets/ROYUAN OLV75" = {
        enable = true;
        source = link "./input-remapper/presets/ROYUAN OLV75";
        recursive = true;
        target = ".config/input-remapper/ROYUAN OLV75";
      };
    };
  };
}
