{ pkgs, ... }:
{

  # used to startup fcitx5
  xsession.windowManager.i3.config.startup = [
    {
      command = "${pkgs.fcitx5}/bin/fcitx5 &";
      always = false;
      notification = false;
    }
  ];
}
