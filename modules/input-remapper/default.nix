{ unstable, ... }:
{
  services.input-remapper = {
    enable = true;
    package = unstable.input-remapper;
  };

}
