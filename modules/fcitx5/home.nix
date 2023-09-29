{ pkgs, ... }:
{

  # used to startup fcitx5
  xsession.windowManager.i3.config.startup = [
    {
      command = "fcitx5 &";
      always = false;
      notification = false;
    }
  ];
}
