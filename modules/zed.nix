{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ zed-editor ];

  home-manager.users.julius =
    { ... }:
    {
      programs.zed-editor.enable = true;
      programs.zed-editor.userSettings = {
        assistant = {
          default_model = {
            provider = "copilot_chat";
            model = "claude-3-5-sonnet";
          };
          version = "2";
        };

        show_edit_predictions = false;

        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        vim_mode = true;
        auto_update = false;
        ensure_final_newline_on_save = false;
        vim.use_system_clipboard = "never";
        relative_line_numbers = true;
        project_panel.dock = "right";

        wrap_guides = [ 80 ];

        lsp.rust-analyzer.binary.path = "/run/current-system/sw/bin/rust-analyzer";
      };
    };
}
