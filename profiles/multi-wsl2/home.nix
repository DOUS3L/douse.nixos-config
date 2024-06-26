{ config, multiwsl2-user, pkgs, unstable, ... }:
{
  home = {
    username = "${multiwsl2-user}";
    homeDirectory = "/home/${multiwsl2-user}";

    packages = [
      unstable.gcc_multi
      unstable.gh
      unstable.kaf
      unstable.kn
      unstable.prettierd
      unstable.istioctl
      unstable.kind
      unstable.hey

      unstable.python39
      unstable.pre-commit

      unstable.go
      unstable.gopls
      unstable.delve

      (unstable.google-cloud-sdk.withExtraComponents [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
      unstable.k9s
      unstable.kubectl
      unstable.kubernetes-helm

      unstable.terraform
      unstable.terragrunt

      unstable.postgresql
      unstable.mysql
      unstable.usql

      unstable.lua-language-server

    ];
  };

  sops = {
    secrets = {
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

  programs = {
    direnv = {
      enable = true;
    };
    zsh = {
      initExtra = ""; 
    };
  };
}
