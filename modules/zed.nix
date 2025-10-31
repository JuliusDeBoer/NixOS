{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ zed-editor ];

  home-manager.users.julius =
    { ... }:
    {
      programs.zed-editor = {
        enable = true;

        extensions = [
          "discord-presence"
        ];

        userSettings = {
          vim_mode = true;
          auto_update = false;

          ensure_final_newline_on_save = true;

          project_panel.dock = "right";

          vim.use_system_clipboard = "never";
          relative_line_numbers = true;
          show_edit_predictions = false;

          buffer_font_features = {
            calt = true;
            dlig = true;
          };

          telemetry = {
            diagnostics = false;
            metrics = false;
          };

          wrap_guides = [ 80 ];

          lsp.rust-analyzer.binary.path = "/run/current-system/sw/bin/rust-analyzer";

          diagnostics = {
            include_warnings = true;
            inline.enabled = true;
          };
        };
      };
    };
}
