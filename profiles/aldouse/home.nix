{ pkgs, user, unstable, ... }:
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
    ];
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
