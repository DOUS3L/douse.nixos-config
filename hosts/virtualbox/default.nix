{ configs, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.${user} = {
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDOVbmxiD14/ZR1kePFEEhpGPjPZh1A4yQfa1cnqw8zBnpWa/EW2aNWqOMjGJ9m0C1GLYPRJZE3nDidSJ6fWjuuBF9fbnJRy+fnk8iJ52qrx0aB08BSBoTY+c8NsukxkNTbLXpHyEr6zvw+Gp2myH2yZ6rP0ZdYuIDvsIGJ9n8cE88/G64jwUgKfCkMuz7GAS/7ozaxNMHG6hm0cmWW4Uf6CCxTjDLH8SKpytN97Q8c9x6aZMRpdi2vv9ppiddNa00NZ66C6gG08crDX7w9wDlMUnt8OGf+rRNoIyluOzN24YyGQvpYwYs0qAtARH644eWRK+FfSOGWKBg/7ZHDBUz aldous@DESKTOP-N6T4RQQ" ];
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        configurationLimit = 15;
      };
    };
  };

  networking.networkmanager.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };
}