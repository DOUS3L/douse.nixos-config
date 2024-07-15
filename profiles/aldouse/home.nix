{ pkgs, user, unstable, config, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = [
      pkgs.python311 # for i3blocks


      # unstable.jetbrains.idea-community

      unstable.discord
      # (unstable.discord.override {
      #   withOpenASAR = true;
      # })
      unstable.scrcpy
      unstable.telegram-desktop
      unstable.anytype
      (unstable.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
      })
      unstable.vivaldi-ffmpeg-codecs
      unstable.slack
      unstable.spotify

      unstable.pre-commit
      (unstable.google-cloud-sdk.withExtraComponents [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
      unstable.bruno
      unstable.gh

      # golang
      unstable.go
      unstable.gopls
      unstable.golangci-lint
      unstable.golangci-lint-langserver
      unstable.delve

      # k8s stuff
      unstable.k9s
      unstable.kubectl
      unstable.kubernetes-helm
      unstable.kn # knative

      unstable.terraform
      unstable.terragrunt

      unstable.postgresql
      unstable.mysql
      unstable.usql

      unstable.obsidian
    ];
  };

  programs = {
    direnv = {
      enable = true;
    };
    zsh = {
      shellAliases = {
        startvpns = "sudo systemctl start openvpn-gcpvpn0.service; sudo systemctl start openvpn-gcpvpn1.service";
      };
    };
  };

  sops = {
    secrets = {
      sshconfig = {
        path = "${config.home.homeDirectory}/.ssh/config";
        mode = "0600";
        sopsFile = ../../secrets/secrets.yaml;
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
    };
  };

  # additional i3 configuration
  # xsession.windowManager.i3.config.startup = [
  #   {
  #     command = "${unstable.discord}/bin/discord";
  #     always = false;
  #     notification = false;
  #   }
  #   {
  #     command = "${pkgs.firefox}/bin/firefox";
  #     always = false;
  #     notification = false;
  #   }
  # ];
}
