{ pkgs, unstable, ...}:
{
  programs = {
    helix = {
      enable = true;
      package = unstable.helix;
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
           space.space = "file_picker";
           space.w = ":w";
           space.q = ":q";
           esc = [ "collapse_selection" "keep_primary_selection" ];
         };
      };
    };
  };
}