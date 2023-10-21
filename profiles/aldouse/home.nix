{ pkgs, user, unstable, config, ... }:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = [
      pkgs.python311 # for i3blocks

      (unstable.discord.override {
        withOpenASAR = true;
      })
      unstable.scrcpy
      unstable.telegram-desktop
    ];
  };

  sops = {
    secrets = {
      sshconfig = {
        path = "${config.home.homeDirectory}/.ssh/config";
        mode = "0600";
        sopsFile = ../../secrets/secrets.yaml;
      };
    };
  };

  # additional i3 configuration
  xsession.windowManager.i3.config.startup = [
    {
      command = "${unstable.discord}/bin/discord";
      always = false;
      notification = false;
    }
    {
      command = "${pkgs.firefox}/bin/firefox";
      always = false;
      notification = false;
    }
  ];

}
