{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      eval "$(zoxide init zsh)"
    '';
  };

  users.users.julius = {
    packages = [ pkgs.zsh ];
    shell = pkgs.zsh;
  };

  home-manager.users.julius =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cyme
        fd
        file
        p7zip
        ripgrep
        tlrc
        tmux
        zoxide

        hellcomp
      ];

      home.shellAliases = {
        md = "mkdir";
        c = "clear";
        q = "exit";
        la = "ls -lha";
        zedq = "zeditor . && exit";

        # Funny
        git = "git ";
        we = "git";
        ball = "push --force-with-lease";
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zsh = {
        enable = true;
        initExtra = "${pkgs.hellcomp}/bin/hellcomp";
        historySubstringSearch.enable = true;
        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.8.0";
              sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
            };
          }
        ];
      };

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          format =
            "$username@$hostname"
            + "( [\\($git_branch( $git_state)( $git_metrics)\\)](purple))"
            + "( [\\($nix_shell\\)](blue))"
            + "\n$directory$character";
          username = {
            format = "[$user]($style)";
            show_always = true;
          };
          hostname = {
            format = "[$ssh_symbol$hostname]($style)";
            ssh_only = false;
          };
          git_branch = {
            format = "[$symbol$branch(:$remote_branch)]($style)";
          };
          git_metrics = {
            disabled = false;
            format = "( [\\[+$added\\]]($added_style))( [\\[-$deleted\\]]($deleted_style))";
          };
          directory = {
            truncate_to_repo = false;
          };
          nix_shell = {
            format = "[$symbol( $name)]($style)";
            symbol = "󱄅 ";
          };
          character = {
            format = "$symbol ";
            success_symbol = "[::](green)";
            error_symbol = "[::](red)";
          };
        };
      };
    };
}
