{ config, unstable, pkgs, bluewheels-user, ... }:
{
  home = {
    username = "${bluewheels-user}";
    homeDirectory = "/home/${bluewheels-user}";

    packages = [
      (unstable.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
      })
      unstable.vivaldi-ffmpeg-codecs
      unstable.slack

      # for development
      (unstable.google-cloud-sdk.withExtraComponents [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])

      pkgs.python310
      pkgs.python310Packages.pip
      pkgs.poetry

      unstable.insomnia

      unstable.kubectl
      unstable.kubernetes-helm
      unstable.k9s
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


  # additional i3 configuration
  xsession.windowManager.i3.config.startup = [
    {
      command = "${unstable.slack}/bin/slack";
      always = false;
      notification = false;
    }
    {
      command = "${unstable.vivaldi}/bin/vivaldi";
      always = false;
      notification = false;
    }
  ];
}
