{ config, oceanedge-user, pkgs, unstable, ... }:
{
  imports = [
    ./sops.nix
  ];
  
  home = {
    username = "${oceanedge-user}";
    homeDirectory = "/home/${oceanedge-user}";

    packages = [
      unstable.gh

      unstable.python39
      unstable.pre-commit

      (unstable.google-cloud-sdk.withExtraComponents [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
      unstable.k9s
      unstable.kubectl
      unstable.kubernetes-helm

      unstable.terraform
      unstable.terragrunt

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
}
