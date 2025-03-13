{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gnupg
    pinentry-curses
  ];

  home-manager.users.julius =
    { ... }:
    {
      programs.git = {
        enable = true;
        userName = "Julius de Boer";
        userEmail = "45075461+JuliusDeBoer@users.noreply.github.com";
        signing = {
          key = "04491B6E0B95C939";
          signByDefault = true;
        };
        extraConfig = {
          init.defaultBranch = "master";
          color = {
            diff = "auto";
            status = "auto";
            branch = "auto";
            interactive = "auto";
            ui = true;
            pager = true;
          };
          rerere.enabled = true;
          branch.sort = "-committerdate";
          pull.ff = "only";
          push.autoSetupRemote = true;
          alias = {
            fucked = "reset --hard HEAD";
          };
        };
      };
    };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };
}
