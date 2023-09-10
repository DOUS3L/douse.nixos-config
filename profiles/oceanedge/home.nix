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
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
      };
      gcpvpn0 = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn0.ovpn";
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
      };
      gcpvpn1 = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn1.ovpn";
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
      };
    };
  };

}
