{ config, oceanedge-user, pkgs, unstable, ... }:
{
  imports = [
    ./sops.nix
  ];
  
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
      unstable.lazydocker

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

      unstable.go
      unstable.gopls
      unstable.delve

      pkgs.postman

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
