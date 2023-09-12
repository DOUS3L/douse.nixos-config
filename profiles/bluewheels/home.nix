{ config, unstable, pkgs, bluewheels-user, ... }:
{
  home = {
    username = "${bluewheels-user}";
    homeDirectory = "/home/${bluewheels-user}";

    packages = [
      unstable.google-cloud-sdk
      unstable.slack

      # for development
      pkgs.python310
      pkgs.python310Packages.pip
      pkgs.poetry
    ];
  };

  programs = {
    zsh = {
      shellAliases = {
        devlvpn = "sudo systemctl stop openvpn-gcpvpn4; sudo systemctl start openvpn-gcpvpn3.service";
        prodvpn = "sudo systemctl stop openvpn-gcpvpn3; sudo systemctl start openvpn-gcpvpn4.service";
      };
    };
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
