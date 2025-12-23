{ pkgs, lib, ... }:

{
  programs.zsh.enable = true;

  users.users.julius = {
    packages = [ pkgs.zsh ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    ani-cli
    atuin
    busybox
    comma
    cyme
    dysk
    eza
    fd
    file
    hellcomp
    joshuto
    p7zip
    ripgrep
    tlrc
    tmux
    zoxide
  ];

  home-manager.users.julius =
    { pkgs, ... }:
    {
      home.shellAliases = {
        md = "mkdir";
        c = "clear";
        q = "exit";
        ls = "eza";
        ll = "eza -lh --git";
        la = "eza -lha --git";
        zedq = "zeditor . && exit";

        # Funny
        git = "git ";
        we = "git";
        ball = "push --force-with-lease";
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        flags = [ "--disable-up-arrow" ];
        daemon.enable = true;
      };

      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;
        initContent = lib.mkOrder 1500 "${pkgs.hellcomp}/bin/hellcomp";
        # NOTE(Julius): Neatly stolen from:
        #               <https://scottspence.com/posts/speeding-up-my-zsh-shell>
        completionInit = ''
          autoload -Uz compinit
          if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
            compinit
          else
            compinit -C
          fi
        '';
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

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          format =
            "$username@$hostname"
            + "( [\\($git_branch( $git_state)($git_metrics)\\)](purple))"
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
            format = "[$symbol($name)]($style)";
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
