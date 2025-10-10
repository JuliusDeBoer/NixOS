{ pkgs, ... }:
{
  home-manager.users.julius =
    { ... }:
    {
      programs.vim = {
        enable = true;
        settings = {
          number = true;
          relativenumber = true;
        };
        plugins = with pkgs.vimPlugins; [
          ale
          nerdtree
          typst-vim
          vim-fugitive
        ];
        extraConfig = "
          set cc=80
        ";
        # Return to monke
        defaultEditor = true;
      };
    };
}
