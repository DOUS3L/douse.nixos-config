{ bluewheels-user, pkgs, ... }:
{
  users.users.${bluewheels-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
    home = "/home/${bluewheels-user}";
  };

  services.openvpn.servers = {
    gcpvpn3 = {
      config = "config /home/${bluewheels-user}/.secrets/gcpvpn3.ovpn";
      autoStart = false;
    };
    gcpvpn4 = {
      config = "config /home/${bluewheels-user}/.secrets/gcpvpn4.ovpn";
      autoStart = false;
    };
  };
}
