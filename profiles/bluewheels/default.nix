{ bluewheels-user, pkgs, ... }:
{
  users.users.${bluewheels-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    home = "/home/${bluewheels-user}";
  };

  services.openvpn.servers = {
    gcpvpn3 = {
      config = "config /home/${bluewheels-user}/.secrets/gcpvpn3.ovpn";
      autoStart = false;
      updateResolvConf = true;
    };
    gcpvpn4 = {
      config = "config /home/${bluewheels-user}/.secrets/gcpvpn4.ovpn";
      autoStart = false;
      updateResolvConf = true;
    };
  };
}
