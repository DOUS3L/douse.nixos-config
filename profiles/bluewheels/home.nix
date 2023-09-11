{ bluewheels-user, ... }:
{
  home = {
    username = "${bluewheels-user}";
    homeDirectory = "/home/${bluewheels-user}";

    packages = [
      unstable.google-cloud-sdk
    ];
  };

  sops = {
    secrets = {
      gcpvpn3 = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn3.ovpn";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
      };
      gcpvpn4 = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn4.ovpn";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
      };
      gcpvpn3cred = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn3cred";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
      };
      gcpvpn4cred = {
        path = "${config.home.homeDirectory}/.secrets/gcpvpn4cred";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
      };
      id_rsa = {
        path = "${config.home.homeDirectory}/.ssh/id_rsa";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
        mode = "0600";
      };
      id_rsa_pub = {
        path = "${config.home.homeDirectory}/.ssh/id_rsa.pub";
        sopsFile = ../../secrets/secrets_bluewheels.yaml;
      };
    };
  };

}
