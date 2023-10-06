{ config, oceanedge-user, pkgs, unstable, ... }:
{
  home = {
    username = "${oceanedge-user}";
    homeDirectory = "/home/${oceanedge-user}";

    packages = [
      (unstable.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
      })
      unstable.vivaldi-ffmpeg-codecs
      unstable.slack
      unstable.spotify
      unstable.gh

      unstable.python39
      unstable.devbox
      unstable.pre-commit

      (unstable.google-cloud-sdk.withExtraComponents [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
      unstable.k9s
      unstable.kubectl
      unstable.kubernetes-helm

      unstable.terraform
      unstable.terragrunt

      unstable.insomnia

      unstable.postgresql
      unstable.mysql
      unstable.usql
    ];
  };

  programs = {
    direnv = {
      enable = true;
    };
    zsh = {
      shellAliases = {
        startvpns = "sudo systemctl start openvpn-alivpn0; sudo systemctl start openvpn-gcpvpn0.service; sudo systemctl start openvpn-gcpvpn1.service";
      };
    };
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
