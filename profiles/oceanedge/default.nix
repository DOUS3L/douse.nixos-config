{ oceanedge-user, pkgs, config, ... }:
{
  users.users.${oceanedge-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    home = "/home/${oceanedge-user}";
  };

  programs.nix-ld.enable = true; 

  services.openvpn.servers = {
    # alivpn0 = {
    #   config = "config /home/${oceanedge-user}/.secrets/alivpn0.ovpn";
    #   autoStart = false;
    #   updateResolvConf = true;
    # };
    gcpvpn0 = {
      config = "config /home/${oceanedge-user}/.secrets/gcpvpn0.ovpn";
      autoStart = false;
      updateResolvConf = true;
    };
    gcpvpn1 = {
      config = "config /home/${oceanedge-user}/.secrets/gcpvpn1.ovpn";
      autoStart = false;
      updateResolvConf = true;
    };
  };
}
