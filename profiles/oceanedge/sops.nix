{ config, oceanedge-user, ... }:
{
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
      id_rsa = {
        path = "${config.home.homeDirectory}/.ssh/id_rsa";
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
        mode = "0600";
      };
      id_rsa_pub = {
        path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
      };
      sshconfig = {
        path = "${config.home.homeDirectory}/.ssh/config";
        mode = "0600";
        sopsFile = ../../secrets/secrets_oceanedge.yaml;
      };
    };
  };
}
