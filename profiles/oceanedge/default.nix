{ oceanedge-user, pkgs, config, ... }:
{
  users.users.${oceanedge-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    home = "/home/${oceanedge-user}";
  };

# config.users.users.${oceanedge-user}.home
  services.openvpn.servers = {
    alivpn0 = { config = "config /home/${oceanedge-user}/.secrets/alivpn0.ovpn"; };
    gcpvpn0 = { config = "config /home/${oceanedge-user}/.secrets/gcpvpn0.ovpn"; };
    gcpvpn1 = { config = "config /home/${oceanedge-user}/.secrets/gcpvpn1.ovpn"; };
  };
}
