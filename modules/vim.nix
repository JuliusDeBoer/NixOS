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
          vim-airline
          vim-airline-themes
          vim-fugitive
        ];
        extraConfig = "
          set cc=80
          let g:airline_theme='distinguished'
          augroup GitCommitSettings
            autocmd!
            autocmd FileType gitcommit set cc=50,72
          augroup END
        ";
        # Return to monke
        defaultEditor = true;
      };
    };
}
