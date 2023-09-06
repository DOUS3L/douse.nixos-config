{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/i3/default.nix
    ../../modules/vscode-server/default.nix
  ];

  users.users.${user} = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDOVbmxiD14/ZR1kePFEEhpGPjPZh1A4yQfa1cnqw8zBnpWa/EW2aNWqOMjGJ9m0C1GLYPRJZE3nDidSJ6fWjuuBF9fbnJRy+fnk8iJ52qrx0aB08BSBoTY+c8NsukxkNTbLXpHyEr6zvw+Gp2myH2yZ6rP0ZdYuIDvsIGJ9n8cE88/G64jwUgKfCkMuz7GAS/7ozaxNMHG6hm0cmWW4Uf6CCxTjDLH8SKpytN97Q8c9x6aZMRpdi2vv9ppiddNa00NZ66C6gG08crDX7w9wDlMUnt8OGf+rRNoIyluOzN24YyGQvpYwYs0qAtARH644eWRK+FfSOGWKBg/7ZHDBUz aldous@DESKTOP-N6T4RQQ"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/svOwRmcB1jb+4Wi++dfyQIS2qFiSbORfsJnkMbKSHToIxjjrPaWaBZxmhLQe3PC1G0nWm8IX31lZx37mcNM7r7nUkN2ktkzJzMkS6+Pdkf6bIDbaapFTUnEbBXTVgkBCBOtaE3S7dDAyHa8eFb6pnfDhRihlBTu4myTyTsJAdYSqLX+fikigPkmuzxO0Tyl6PHRDcPiXUDN9CLBrjujpfhivdjgP1ulcpeEYRJRQHQLidLeDYEoOO8E3mZhrEYecVXbtYKV0J1DjNMJkhRtiKHOrprozIPjswEaoqH5HeO3cAjNhUcNgvnDJFc1FeEbOU4em74ozsgW0sjy/zzoFXTIKP8P/tKhHef1hlA9NZPbgoKUl5MsEacsKxDacgt+P9wftQibaFZ1z9+/FtdkANJlZE0FKbYnN7ZZTm8+HQLNOofqY4wx8LjY58XiR956yJtaBAYtRn81RSvPcehQG2GCVT/zXaXHgD+XNCmVA0ofhshJPcHi/PCGhUOAAVKc= aldouse@DESKTOP-N6T4RQQ"
    ];

  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        configurationLimit = 10;
      };
    };
  };

  networking.networkmanager.enable = true;

  services = {
    openssh.enable = true;
    vscode-server.enable = true;
    xserver = {
      layout = "us";
      resolutions = [
        { x = 1440; y = 900; }
        #{ x = 1920; y = 1080; }
      ];
    };
  };


}
