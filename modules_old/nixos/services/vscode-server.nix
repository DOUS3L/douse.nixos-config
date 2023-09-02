{ ... }:
{
  imports = [
    (fetchTarball {
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
      sha256 = "sha256:0sz8njfxn5bw89n6xhlzsbxkafb6qmnszj4qxy2w0hw2mgmjp829";
    })
  ];

  services.vscode-server.enable = true;
  # do not forget to run
  # systemctl --user enable auto-fix-vscode-server.service
  # systemctl --user start auto-fix-vscode-server.service
  # ln -sfT /run/current-system/etc/systemd/user/auto-fix-vscode-server.service ~/.config/systemd/user/auto-fix-vscode-server.service
}
