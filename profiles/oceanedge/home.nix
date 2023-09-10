{ config, oceanedge-user, ... }:
{
  home = {
    username = "${oceanedge-user}";
    homeDirectory = "/home/${oceanedge-user}";
  };

  sops = {
    secrets = {
      alivpn0 = {
        path = "${config.home.homeDirectory}/.secrets/alivpn0.ovpn";
        sopsFile = ../../secrets/oceanedge.yaml;
      };
      gcpvpn0 = {
        path = "${config.home.homeDirectory}/.secrets/alivpn0.ovpn";
        sopsFile = ../../secrets/oceanedge.yaml;
      };
      gcpvpn1 = {
        path = "${config.home.homeDirectory}/.secrets/alivpn0.ovpn";
        sopsFile = ../../secrets/oceanedge.yaml;
      };
    };
  };

}