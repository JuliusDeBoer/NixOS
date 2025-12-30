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
          vim-airline
          vim-airline-themes
        ];
        extraConfig = "
          set cc=80
          let g:airline_theme='distinguished'
        ";
        # Return to monke
        defaultEditor = true;
      };
    };
}
