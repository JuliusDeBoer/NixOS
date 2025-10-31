{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
    git
    gnupg
  ];

  home-manager.users.julius =
    { ... }:
    {
      programs.git = {
        enable = true;
        signing = {
          key = "04491B6E0B95C939";
          signByDefault = true;
        };
        settings = {
          init.defaultBranch = "master";
          user = {
            name = "Julius de Boer";
            mail = "45075461+JuliusDeBoer@users.noreply.github.com";
          };
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
